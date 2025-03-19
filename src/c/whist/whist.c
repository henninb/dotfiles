#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define NUM_PLAYERS 4
#define HAND_SIZE 13
#define DECK_SIZE 52

typedef enum { CLUBS, DIAMONDS, HEARTS, SPADES } Suit;
const char *suit_names[] = {"Clubs", "Diamonds", "Hearts", "Spades"};
/* Unicode icons for suits */
/* const char *suit_icons[] = {"♣", "♦", "♥", "♠"}; */
const char *suit_icons[] = {"\uf327", "\uf2f2", "\uf004", "\uf2e5"};

typedef enum { TWO = 2, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT,
               NINE, TEN, JACK, QUEEN, KING, ACE } Rank;
const char *rank_names[] = {
    "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"
};

typedef struct {
    Suit suit;
    Rank rank;
} Card;

typedef struct {
    Card hand[HAND_SIZE];
    int num_cards;
} Player;

/* Initialize deck in order */
void init_deck(Card deck[]) {
    int i = 0, s, r;
    for (s = CLUBS; s <= SPADES; s++) {
        for (r = TWO; r <= ACE; r++) {
            deck[i].suit = (Suit)s;
            deck[i].rank = (Rank)r;
            i++;
        }
    }
}

/* Shuffle deck using Fisher–Yates shuffle */
void shuffle_deck(Card deck[]) {
    int i, j;
    Card temp;
    for (i = DECK_SIZE - 1; i > 0; i--) {
        j = rand() % (i + 1);
        temp = deck[i];
        deck[i] = deck[j];
        deck[j] = temp;
    }
}

/* Deal cards evenly to each player */
void deal_cards(Card deck[], Player players[]) {
    int i, p;
    for (p = 0; p < NUM_PLAYERS; p++) {
        players[p].num_cards = 0;
    }
    for (i = 0; i < DECK_SIZE; i++) {
        p = i % NUM_PLAYERS;
        players[p].hand[players[p].num_cards] = deck[i];
        players[p].num_cards++;
    }
}

/* Print a single card using Unicode suit icons */
void print_card(Card card) {
    /* Use rank and Unicode suit icon */
    printf("%s%s", rank_names[card.rank - TWO], suit_icons[card.suit]);
}

/* Print player's hand with index numbers */
void print_hand(Player *player) {
    int i;
    for (i = 0; i < player->num_cards; i++) {
        printf("[%d] ", i);
        print_card(player->hand[i]);
        printf("   ");
    }
    printf("\n");
}

/* Check if the chosen index is valid. If suit requirement applies (has_led),
   then the player must play a card of the suit led if possible. */
int valid_card_index(Player *player, int index, Suit suit_led, int has_led) {
    int i, hasSuit = 0;
    if (index < 0 || index >= player->num_cards)
        return 0;
    if (!has_led)
        return 1;
    /* Check if player has any card of suit_led */
    for (i = 0; i < player->num_cards; i++) {
        if (player->hand[i].suit == suit_led) {
            hasSuit = 1;
            break;
        }
    }
    if (hasSuit && player->hand[index].suit != suit_led)
        return 0;
    return 1;
}

/* Remove the card at index from player's hand and return it */
Card remove_card(Player *player, int index) {
    Card chosen = player->hand[index];
    int i;
    for (i = index; i < player->num_cards - 1; i++) {
        player->hand[i] = player->hand[i + 1];
    }
    player->num_cards--;
    return chosen;
}

/* Compare two cards to decide if card a wins over card b.
   The rules are:
     - A trump card beats a non-trump card.
     - If neither (or both) are trump, a card that follows the suit led wins over one that does not.
     - If both cards are of the same suit (the trump suit or suit led), the higher rank wins.
*/
int compare_cards(Card a, Card b, Suit suit_led, Suit trump) {
    /* Check trump */
    if (a.suit == trump && b.suit != trump)
        return 1;
    if (b.suit == trump && a.suit != trump)
        return 0;
    /* Check suit led */
    if (a.suit == suit_led && b.suit != suit_led)
        return 1;
    if (b.suit == suit_led && a.suit != suit_led)
        return 0;
    /* Both cards follow suit led */
    if (a.suit == suit_led && b.suit == suit_led) {
        if (a.rank > b.rank)
            return 1;
        else
            return 0;
    }
    /* If neither card is trump or following suit, neither can win */
    return 0;
}

/* Determine the winner of a trick.
   trick_cards is an array indexed by player number.
   first_player is the index of the player who led the trick.
*/
int determine_trick_winner(Card trick_cards[], int first_player, Suit suit_led, Suit trump) {
    int winner = first_player;
    int i, current_player;
    for (i = 1; i < NUM_PLAYERS; i++) {
        current_player = (first_player + i) % NUM_PLAYERS;
        if (compare_cards(trick_cards[current_player], trick_cards[winner], suit_led, trump))
            winner = current_player;
    }
    return winner;
}

/* Simple computer AI: choose a legal card.
   If following suit, play the first card found that follows suit.
   Otherwise, play the first card in hand.
*/
int computer_choose_card(Player *computer, Suit suit_led, int has_led) {
    int i, chosen = -1;
    if (has_led) {
        for (i = 0; i < computer->num_cards; i++) {
            if (computer->hand[i].suit == suit_led) {
                chosen = i;
                break;
            }
        }
    }
    if (chosen == -1) {
        chosen = 0;
    }
    return chosen;
}

int main() {
    Card deck[DECK_SIZE];
    Player players[NUM_PLAYERS];
    int trick, i, choice, valid;
    int trick_wins[NUM_PLAYERS] = {0, 0, 0, 0};
    int human_player = 0; /* Human is player 0; partner is player 2 */
    int current_player = 0; /* Player who leads the trick */
    Card trick_cards[NUM_PLAYERS];
    Suit suit_led = CLUBS; /* default initialization */
    int has_led = 0;
    int winner;

    srand((unsigned int) time(NULL));
    init_deck(deck);
    shuffle_deck(deck);
    deal_cards(deck, players);

    /* Determine trump suit from the first card of the deck */
    Suit trump = deck[0].suit;
    printf("Trump suit is %s %s\n", suit_names[trump], suit_icons[trump]);

    /* Play 13 tricks */
    for (trick = 0; trick < HAND_SIZE; trick++) {
        printf("\nTrick %d:\n", trick + 1);
        has_led = 0;
        /* Each player plays in turn, starting with current_player */
        for (i = 0; i < NUM_PLAYERS; i++) {
            int player = (current_player + i) % NUM_PLAYERS;
            if (player == human_player) {
                printf("Your hand:\n");
                print_hand(&players[human_player]);
                valid = 0;
                do {
                    printf("Select card index to play: ");
                    if (scanf("%d", &choice) != 1) {
                        while(getchar() != '\n'); /* clear invalid input */
                        printf("Invalid input. Try again.\n");
                        continue;
                    }
                    if (!valid_card_index(&players[human_player], choice, suit_led, has_led)) {
                        printf("Invalid card selection. You must follow suit if possible.\n");
                    } else {
                        valid = 1;
                    }
                } while (!valid);
                /* Remove and play the chosen card */
                trick_cards[human_player] = remove_card(&players[human_player], choice);
                printf("You played: ");
                print_card(trick_cards[human_player]);
                printf("\n");
                if (!has_led) {
                    suit_led = trick_cards[human_player].suit;
                    has_led = 1;
                }
            } else {
                int comp_choice = computer_choose_card(&players[player], suit_led, has_led);
                trick_cards[player] = remove_card(&players[player], comp_choice);
                printf("Player %d played: ", player);
                print_card(trick_cards[player]);
                printf("\n");
                if (!has_led) {
                    suit_led = trick_cards[player].suit;
                    has_led = 1;
                }
            }
        }

        /* Determine the winner of the trick */
        winner = determine_trick_winner(trick_cards, current_player, suit_led, trump);
        printf("Player %d wins the trick.\n", winner);
        trick_wins[winner]++;
        current_player = winner;  /* winner leads next trick */
    }

    /* Tally and display final scores */
    printf("\nGame over. Trick wins:\n");
    for (i = 0; i < NUM_PLAYERS; i++) {
        printf("Player %d: %d tricks\n", i, trick_wins[i]);
    }
    /* In traditional Whist, players 0 and 2 are partners versus 1 and 3 */
    int team1 = trick_wins[0] + trick_wins[2];
    int team2 = trick_wins[1] + trick_wins[3];
    printf("\nTeam (Players 0 & 2) scored: %d tricks\n", team1);
    printf("Team (Players 1 & 3) scored: %d tricks\n", team2);
    if (team1 > team2)
        printf("You and your partner win!\n");
    else if (team1 < team2)
        printf("Computer team wins. Better luck next time!\n");
    else
        printf("It's a tie!\n");

    return 0;
}
