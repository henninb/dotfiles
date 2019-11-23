package excel_to_db.services;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.poi.poifs.crypt.Decryptor;
import org.apache.poi.poifs.crypt.EncryptionInfo;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import excel_to_db.domain.Transaction;
import org.springframework.core.env.Environment;
import java.io.*;
import java.util.Date;
import java.util.stream.IntStream;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

@Service
public class ExcelService {
    private Environment env;
    private final ObjectMapper mapper = new ObjectMapper();

    private static final int COL_GUID = 1;
    private static final int COL_TRANSACTION_DATE = 2;
    private static final int COL_DESCRIPTION = 3;
    private static final int COL_CATEGORY = 4;
    private static final int COL_AMOUNT = 5;
    private static final int COL_CLEARED = 6;
    private static final int COL_NOTES = 7;
    private static final int COL_DATE_ADDED = 8;
    private static final int COL_DATE_UPDATED = 9;

    public ExcelService(Environment env) {
        this.env = env;
    }

    @Scheduled(fixedDelay = 1000 * 20)
    public void readPasswordProtected() throws Exception {
        String fname = env.getProperty("custom.project.excel.file-path") + "/" + "finance_db_master.xlsm";
        String ofname = env.getProperty("custom.project.excel.file-path") + "/" + "finance_db_master_new.xlsm";
      try {
        POIFSFileSystem fs = new POIFSFileSystem(new FileInputStream(fname));
        EncryptionInfo info = new EncryptionInfo(fs);

        Decryptor decryptor = Decryptor.getInstance(info);
        decryptor.verifyPassword(env.getProperty("custom.project.excel.password"));

        InputStream is = decryptor.getDataStream(fs);

        Workbook workbook = new XSSFWorkbook(is);

          IntStream.range(0, workbook.getNumberOfSheets()).filter(idx -> ( (workbook.getSheetName(idx).contains("_brian") || workbook.getSheetName(idx).contains("_kari")) && ! workbook.isSheetHidden(idx)  )).forEach(idx -> {


              if (!workbook.getSheetName(idx).contentEquals("giftcards_brian") && !workbook.getSheetName(idx).contentEquals("scottrade_ira_brian") && !workbook.getSheetName(idx).contentEquals("vacation_brian") && !workbook.getSheetName(idx).contentEquals("vacation_kari") && !workbook.getSheetName(idx).contentEquals("401k_brian") && !workbook.getSheetName(idx).contentEquals("401k_kari") && !workbook.getSheetName(idx).contentEquals("pension_brian") && !workbook.getSheetName(idx).contentEquals("pension_kari") && !workbook.getSheetName(idx).contentEquals("amazongift_brian")
              ) {
                System.out.println("Sheet name: " + workbook.getSheetName(idx).trim() );
                  try {
                      this.printSheet(workbook, idx);
                  } catch (JsonProcessingException e) {
                      e.printStackTrace();
                  }
              }
          });

          is.close();

          FileOutputStream outFile = new FileOutputStream(new File(ofname));
          workbook.write(outFile);
          outFile.close();
          System.exit(2);

        } catch( FileNotFoundException e) {
            e.printStackTrace();
        }
    }

    private void printSheet(Workbook workbook, int sheetNumber ) throws JsonProcessingException {
        Sheet datatypeSheet = workbook.getSheetAt(sheetNumber);
        boolean blank = false;

        for (Row currentRow : datatypeSheet) {
                Transaction transaction = new Transaction();
                transaction.setAccountNameOwner(workbook.getSheetName(sheetNumber).trim());
            for (Cell currentCell : currentRow) {
                int col = currentCell.getColumnIndex();
                blank = false;
                if ( col == COL_GUID && currentCell.getStringCellValue().trim().equals("") ) {
                  blank = true;
                  break;
                }
                if (currentCell.getAddress().getRow() != 0 ) {
                  if (currentCell.getCellType() == CellType.STRING) {
                      if ( col == COL_GUID ) {
                        String val = currentCell.getStringCellValue().trim();
                        transaction.setGuid(val);
                      } else if ( col == COL_DESCRIPTION ) {
                        String val = capitalizeWords(currentCell.getStringCellValue().trim());
                        transaction.setDescription(val);
                      } else if ( col == COL_CATEGORY ) {
                        String val = currentCell.getStringCellValue().trim();
                        transaction.setCategory(val);
                      } else if ( col == COL_NOTES ) {
                        String val = capitalizeWords(currentCell.getStringCellValue().trim());
                        transaction.setNotes(val);
                      } else {
                        System.out.print(currentCell.getStringCellValue().trim() + "--");
                      }
                  } else if (currentCell.getCellType() == CellType.NUMERIC) {
                      if ( col == COL_CLEARED ) {
                        int val = (int)currentCell.getNumericCellValue();
                        transaction.setCleared(val);
                      } else if ( col == COL_DATE_UPDATED ) {
                        Date date = DateUtil.getJavaDate(currentCell.getNumericCellValue());
                        transaction.setDateUpdated(date);
                      } else if ( col == COL_DATE_ADDED ) {
                        Date date = DateUtil.getJavaDate(currentCell.getNumericCellValue());
                        transaction.setDateAdded(date);
                      } else if ( col == COL_TRANSACTION_DATE ) {
                        Date date = DateUtil.getJavaDate(currentCell.getNumericCellValue());
                        transaction.setTransactionDate(date);
                      } else if ( col == COL_AMOUNT ) {
                        BigDecimal val = new BigDecimal(currentCell.getNumericCellValue());
                        transaction.setAmount(val);
                      } else {
                        System.out.print(currentCell.getNumericCellValue() + "--");
                      }
                  } else if (currentCell.getCellType() == CellType.BLANK) {
                  } else if (currentCell.getCellType() == CellType.FORMULA) {
                  } else {
                    System.out.println("currentCell.getCellType()="+ currentCell.getCellType());
                    System.exit(1);
                  }
                }
            }
            if ( !blank ) {
              System.out.println(mapper.writeValueAsString(transaction));
              System.out.println();
            }
        }
    }

    private String capitalizeWords(String str) {
        if (str.length() > 0) {
            String[] words = str.toLowerCase().split("\\s");
            StringBuilder capitalizeWord = new StringBuilder();
            for (String w : words) {
                if ( w.length() > 0 ) {
                    String first = w.substring(0, 1);
                    String afterfirst = w.substring(1);
                    capitalizeWord.append(first.toUpperCase()).append(afterfirst).append(" ");
                } else {
                    capitalizeWord.append(w);
                }
            }
            return capitalizeWord.toString().trim();
       }
       return str;
    }
}
