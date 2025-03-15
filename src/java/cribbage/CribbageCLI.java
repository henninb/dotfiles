import java.util.*;
import java.util.stream.Collectors;

public class CribbageCLI {

    // Enum for Suits
    enum Suit {
        HEARTS("♥"),
        DIAMONDS("♦"),
        CLUBS("♣"),
        SPADES("♠");

        private final String symbol;
        Suit(String symbol) { this.symbol = symbol; }
        public String getSymbol() { return symbol; }
    }

    // Enum for Ranks with associated display label and value
    enum Rank {
        ACE("A", 1),
        TWO("2", 2),
        THREE("3", 3),
        FOUR("4", 4),
        FIVE("5", 5),
        SIX("6", 6),
        SEVEN("7", 7),
        EIGHT("8", 8),
        NINE("9", 9),
        TEN("10", 10),
        JACK("J", 10),
        QUEEN("Q", 10),
        KING("K", 10);

        private final String label;
        private final int value;
        Rank(String label, int value) {
            this.label = label;
            this.value = value;
        }
        public String getLabel() { return label; }
        public int getValue() { return value; }
    }

    // Card class
    static class Card {
        Rank rank;
        Suit suit;
        public Card(Rank rank, Suit suit) {
            this.rank = rank;
            this.suit = suit;
        }
        public int getValue() {
            return rank.getValue();
        }
        @Override
        public String toString() {
            return rank.getLabel() + suit.getSymbol();
        }
    }

    // Game state variables
    private boolean gameStarted = false;
    private int playerScore = 0;
    private int opponentScore = 0;
    private boolean isPlayerDealer = false;
    private List<Card> playerHand = new ArrayList<>();
    private List<Card> opponentHand = new ArrayList<>();

    // Pegging-phase variables
    private boolean isPeggingPhase = false;
    private boolean isPlayerTurn = false;
    private int peggingCount = 0;
    private List<Card> peggingPile = new ArrayList<>();
    private int consecutiveGoes = 0;
    private Card starterCard = null;
    private String lastPlayer = ""; // "Player" or "Opponent"

    // Input & random number generator
    private final Scanner scanner = new Scanner(System.in);
    private final Random random = new Random();

    public static void main(String[] args) {
        CribbageCLI game = new CribbageCLI();
        game.runGame();
    }

    public void runGame() {
        startNewGame();
        dealCards();
        selectCardsForCrib();
        startPeggingPhase();
        System.out.println("\n--- Final Scores ---");
        System.out.println("You: " + playerScore + " points");
        System.out.println("Opponent: " + opponentScore + " points");
    }

    // Initializes a new game round.
    private void startNewGame() {
        gameStarted = true;
        playerScore = 0;
        opponentScore = 0;
        playerHand.clear();
        opponentHand.clear();
        peggingPile.clear();
        consecutiveGoes = 0;
        peggingCount = 0;
        starterCard = null;

        // Randomly decide who is dealer (dealer gets different treatment in pegging)
        isPlayerDealer = random.nextBoolean();
        System.out.println("New cribbage game started.");
        System.out.println(isPlayerDealer ? "You are the dealer." : "Opponent is the dealer.");
    }

    // Deals 6 cards to each player from a shuffled deck.
    private void dealCards() {
        List<Card> deck = createDeck();
        for (int i = 0; i < 6; i++) {
            playerHand.add(deck.remove(0));
            opponentHand.add(deck.remove(0));
        }
        System.out.println("\nCards have been dealt.");
        displayHand("Your hand:", playerHand);
    }

    // Creates and shuffles a standard 52-card deck.
    private List<Card> createDeck() {
        List<Card> deck = new ArrayList<>();
        for (Suit suit : Suit.values()) {
            for (Rank rank : Rank.values()) {
                deck.add(new Card(rank, suit));
            }
        }
        Collections.shuffle(deck);
        return deck;
    }

    // Displays a given hand with index numbers.
    private void displayHand(String message, List<Card> hand) {
        System.out.println(message);
        for (int i = 0; i < hand.size(); i++) {
            System.out.println("[" + i + "] " + hand.get(i));
        }
    }

    // Prompts the user to select 2 cards for the crib; the opponent randomly discards 2 cards.
    private void selectCardsForCrib() {
        System.out.println("\nSelect 2 cards from your hand to discard to the crib (enter two indices separated by a space):");
        int firstIndex = -1, secondIndex = -1;
        while (true) {
            String line = scanner.nextLine();
            String[] parts = line.trim().split("\\s+");
            if (parts.length == 2) {
                try {
                    firstIndex = Integer.parseInt(parts[0]);
                    secondIndex = Integer.parseInt(parts[1]);
                    if (firstIndex >= 0 && firstIndex < playerHand.size() &&
                        secondIndex >= 0 && secondIndex < playerHand.size() &&
                        firstIndex != secondIndex) {
                        break;
                    }
                } catch (NumberFormatException e) {
                    // continue prompting
                }
            }
            System.out.println("Please enter two valid, distinct indices.");
        }
        // Remove the two cards (remove the higher index first to avoid shifting)
        int maxIndex = Math.max(firstIndex, secondIndex);
        int minIndex = Math.min(firstIndex, secondIndex);
        Card cribCard1 = playerHand.remove(maxIndex);
        Card cribCard2 = playerHand.remove(minIndex);
        System.out.println("You selected " + cribCard1 + " and " + cribCard2 + " for the crib.");

        // Opponent randomly discards 2 cards for the crib.
        List<Card> opponentCrib = new ArrayList<>();
        for (int i = 0; i < 2; i++) {
            int idx = random.nextInt(opponentHand.size());
            opponentCrib.add(opponentHand.remove(idx));
        }
        System.out.println("Opponent has selected cards for the crib.");

        // Show remaining hand.
        displayHand("\nYour remaining hand:", playerHand);

        // Cut a card (from a new deck) for the starter.
        List<Card> deck = createDeck();
        starterCard = deck.get(0);
        System.out.println("\nCut card (starter): " + starterCard);
    }

    // Runs the pegging phase where players alternate playing cards (or say "GO")
    private void startPeggingPhase() {
        System.out.println("\n--- Starting Pegging Phase ---");
        isPeggingPhase = true;
        // In pegging, the non-dealer plays first.
        isPlayerTurn = !isPlayerDealer;

        // Continue until both players have played all their cards.
        while (!playerHand.isEmpty() || !opponentHand.isEmpty()) {
            if (isPlayerTurn) {
                System.out.println("\nYour turn. Current pegging count: " + peggingCount);
                displayHand("Your available cards:", playerHand);
                if (canPlay(playerHand, peggingCount)) {
                    System.out.println("Enter the index of the card to play, or type 'go' if you cannot play:");
                    String input = scanner.nextLine().trim();
                    if (input.equalsIgnoreCase("go")) {
                        System.out.println("You say GO!");
                        consecutiveGoes++;
                        if (consecutiveGoes == 2 || (playerHand.isEmpty() && opponentHand.isEmpty())) {
                            if (!peggingPile.isEmpty()) {
                                System.out.println(lastPlayer + " scores 1 point for the last card.");
                                if (lastPlayer.equals("Player")) {
                                    playerScore++;
                                } else {
                                    opponentScore++;
                                }
                            }
                            resetPeggingSegment();
                        }
                    } else {
                        try {
                            int cardIndex = Integer.parseInt(input);
                            if (cardIndex < 0 || cardIndex >= playerHand.size()) {
                                System.out.println("Invalid index.");
                                continue;
                            }
                            Card selected = playerHand.get(cardIndex);
                            if (peggingCount + selected.getValue() > 31) {
                                System.out.println("Playing this card would exceed 31. Choose another card or type 'go'.");
                                continue;
                            }
                            // Play the card.
                            playerHand.remove(cardIndex);
                            peggingPile.add(selected);
                            peggingCount += selected.getValue();
                            lastPlayer = "Player";
                            System.out.println("You played: " + selected + ". New count: " + peggingCount);
                            int score = checkPeggingScore(selected);
                            if (score > 0) {
                                playerScore += score;
                                System.out.println("You scored " + score + " points!");
                            }
                            consecutiveGoes = 0; // reset because a card was played

                            if (peggingCount == 31) {
                                System.out.println("Count reached 31! You score 2 points.");
                                playerScore += 2;
                                resetPeggingSegment();
                            }
                        } catch (NumberFormatException e) {
                            System.out.println("Invalid input. Please enter a valid index or 'go'.");
                            continue;
                        }
                    }
                } else {
                    System.out.println("No playable card. You must say GO.");
                    consecutiveGoes++;
                    if (consecutiveGoes == 2 || (playerHand.isEmpty() && opponentHand.isEmpty())) {
                        if (!peggingPile.isEmpty()) {
                            System.out.println(lastPlayer + " scores 1 point for the last card.");
                            if (lastPlayer.equals("Player")) {
                                playerScore++;
                            } else {
                                opponentScore++;
                            }
                        }
                        resetPeggingSegment();
                    }
                }
                isPlayerTurn = false;  // switch turn to opponent
            } else {
                System.out.println("\nOpponent's turn. Current pegging count: " + peggingCount);
                if (canPlay(opponentHand, peggingCount)) {
                    // Choose a random playable card.
                    List<Integer> playableIndices = new ArrayList<>();
                    for (int i = 0; i < opponentHand.size(); i++) {
                        if (peggingCount + opponentHand.get(i).getValue() <= 31) {
                            playableIndices.add(i);
                        }
                    }
                    int chosenIndex = playableIndices.get(random.nextInt(playableIndices.size()));
                    Card played = opponentHand.remove(chosenIndex);
                    peggingPile.add(played);
                    peggingCount += played.getValue();
                    lastPlayer = "Opponent";
                    System.out.println("Opponent played: " + played + ". New count: " + peggingCount);
                    int score = checkPeggingScore(played);
                    if (score > 0) {
                        opponentScore += score;
                        System.out.println("Opponent scored " + score + " points!");
                    }
                    consecutiveGoes = 0;
                    if (peggingCount == 31) {
                        System.out.println("Count reached 31! Opponent scores 2 points.");
                        opponentScore += 2;
                        resetPeggingSegment();
                    }
                } else {
                    System.out.println("Opponent cannot play and says GO!");
                    consecutiveGoes++;
                    if (consecutiveGoes == 2 || (playerHand.isEmpty() && opponentHand.isEmpty())) {
                        if (!peggingPile.isEmpty()) {
                            System.out.println(lastPlayer + " scores 1 point for the last card.");
                            if (lastPlayer.equals("Opponent")) {
                                opponentScore++;
                            } else {
                                playerScore++;
                            }
                        }
                        resetPeggingSegment();
                    }
                }
                isPlayerTurn = true; // switch back to player
            }
        }
        System.out.println("\nPegging phase complete.");
        System.out.println("Pegging pile: " +
            peggingPile.stream().map(Card::toString).collect(Collectors.joining(", ")));
    }

    // Returns true if at least one card in hand can be played without exceeding 31.
    private boolean canPlay(List<Card> hand, int currentCount) {
        for (Card card : hand) {
            if (currentCount + card.getValue() <= 31) {
                return true;
            }
        }
        return false;
    }

    // Resets the pegging segment after both players say "GO" or the count reaches 31.
    private void resetPeggingSegment() {
        System.out.println("Resetting pegging segment. Count goes back to 0.");
        peggingCount = 0;
        consecutiveGoes = 0;
        peggingPile.clear();
    }

    // Checks the pegging pile for scoring events (15, 31, pairs, and runs).
    private int checkPeggingScore(Card playedCard) {
        int score = 0;
        // Check for fifteen.
        if (peggingCount == 15) {
            score += 2;
            System.out.println("Fifteen for 2 points!");
        }
        // Check for thirty-one.
        if (peggingCount == 31) {
            score += 2;
            System.out.println("Thirty-one for 2 points!");
        }
        // Check for pairs (including three or four of a kind).
        int sameRankCount = 0;
        ListIterator<Card> it = peggingPile.listIterator(peggingPile.size());
        while (it.hasPrevious()) {
            Card card = it.previous();
            if (card.rank == playedCard.rank) {
                sameRankCount++;
            } else {
                break;
            }
        }
        if (sameRankCount == 2) {
            score += 2;
            System.out.println("Pair for 2 points!");
        } else if (sameRankCount == 3) {
            score += 6;
            System.out.println("Three of a kind for 6 points!");
        } else if (sameRankCount == 4) {
            score += 12;
            System.out.println("Four of a kind for 12 points!");
        }
        // Check for runs (a sequence of 3 or more).
        int runScore = 0;
        for (int runLength = Math.min(7, peggingPile.size()); runLength >= 3; runLength--) {
            List<Card> lastCards = peggingPile.subList(peggingPile.size() - runLength, peggingPile.size());
            List<Integer> ranks = lastCards.stream()
                                             .map(c -> c.rank.ordinal())
                                             .sorted()
                                             .collect(Collectors.toList());
            boolean isRun = true;
            for (int i = 0; i < ranks.size() - 1; i++) {
                if (ranks.get(i + 1) - ranks.get(i) != 1) {
                    isRun = false;
                    break;
                }
            }
            if (isRun) {
                runScore = runLength;
                System.out.println("Run of " + runLength + " for " + runLength + " points!");
                break; // only count the longest run found
            }
        }
        score += runScore;
        return score;
    }
}
