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

    public ExcelService(Environment env) {
        this.env = env;
    }

    @Scheduled(fixedDelay = 1000 * 20)
    public void readPasswordProtected() throws Exception {
        String fname = env.getProperty("custom.project.excel.file-path") + "/" + "finance_db_master.xlsm";
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

        } catch( FileNotFoundException e) {
            e.printStackTrace();
        }
    }

    private void printSheet(Workbook workbook, int sheetNumber) {
        Sheet datatypeSheet = workbook.getSheetAt(sheetNumber);

        for (Row currentRow : datatypeSheet) {

            for (Cell currentCell : currentRow) {
                if (currentCell.getCellType() == CellType.STRING) {

                    System.out.print(  capitalizeWords( currentCell.getStringCellValue().trim() ) + "--");
        //            System.out.print(   currentCell.getStringCellValue().trim() + "--");
                } else if (currentCell.getCellType() == CellType.NUMERIC) {
                    System.out.print(currentCell.getNumericCellValue() + "--");
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
