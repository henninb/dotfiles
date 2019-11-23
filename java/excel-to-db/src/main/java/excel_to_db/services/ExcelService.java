package excel_to_db.services;

import org.apache.poi.poifs.crypt.Decryptor;
import org.apache.poi.poifs.crypt.EncryptionInfo;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.core.env.Environment;
import java.io.*;
import java.util.stream.IntStream;

@Service
public class ExcelService {
    private Environment env;
    private static final int COL_GUID = 1;
    private static final int COL_DESCRIPTION = 3;
    private static final int COL_CATEGORY = 4;
    private static final int COL_NOTES = 7;

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

          //sheetMap.put(workbook.getSheetName(idx), idx);
          IntStream.range(0, workbook.getNumberOfSheets()).filter(idx -> ( (workbook.getSheetName(idx).contains("_brian") || workbook.getSheetName(idx).contains("_kari")) && ! workbook.isSheetHidden(idx)  )).forEach(idx -> {


if( workbook.getSheetName(idx).contentEquals("giftcards_brian") || workbook.getSheetName(idx).contentEquals("scottrade_ira_brian") || workbook.getSheetName(idx).contentEquals("vacation_brian") || workbook.getSheetName(idx).contentEquals("vacation_kari") || workbook.getSheetName(idx).contentEquals("401k_brian") || workbook.getSheetName(idx).contentEquals("401k_kari") || workbook.getSheetName(idx).contentEquals("pension_brian") || workbook.getSheetName(idx).contentEquals("pension_kari") || workbook.getSheetName(idx).contentEquals("amazongift_brian")
                ) {
                } else {

                System.out.println("Sheet name: " + workbook.getSheetName(idx).trim() );
                this.printSheet(workbook, idx);
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

    private void printSheet(Workbook workbook, int sheetNumber) {
        Sheet datatypeSheet = workbook.getSheetAt(sheetNumber);

        for (Row currentRow : datatypeSheet) {
            for (Cell currentCell : currentRow) {
                int col = currentCell.getColumnIndex();
                if (currentCell.getAddress().getRow() != 0 ) {
                  if (currentCell.getCellType() == CellType.STRING) {
                      if ( col == COL_DESCRIPTION || col == COL_NOTES ) {
                        System.out.print(  capitalizeWords( currentCell.getStringCellValue().trim() ) + "--");
                      } else {
                        System.out.print(currentCell.getStringCellValue().trim() + "--");
                      }
                  } else if (currentCell.getCellType() == CellType.NUMERIC) {
                      System.out.print(currentCell.getNumericCellValue() + "--");
                  } else if (currentCell.getCellType() == CellType.BLANK) {
                  } else if (currentCell.getCellType() == CellType.FORMULA) {
                  } else {
                    System.out.println("currentCell.getCellType()="+ currentCell.getCellType());
                    System.exit(1);
                  }

                }
            }
            System.out.println();
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

    private String capitalizeString(String element) {
        char[] chars = element.toLowerCase().toCharArray();
        boolean found = false;
        int i = 0;
        while (i < chars.length) {
            if (!found && Character.isLetter(chars[i])) {
                chars[i] = Character.toUpperCase(chars[i]);
                found = true;
            } else if (Character.isWhitespace(chars[i]) ) {
            //} else if (chars[i] == ' ' ) {
                found = false;
            }
            i++;
        }
        return String.valueOf(chars);
    }
}
