package example_excel.services;

import org.apache.poi.poifs.crypt.Decryptor;
import org.apache.poi.poifs.crypt.EncryptionInfo;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.core.env.Environment;
import java.io.*;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

@Service
public class ExcelService {
    private Environment env;

    public ExcelService(Environment env) {
        this.env = env;
    }

    //private String FILE_NAME = env.getProperty("custom.project.excel.file-path") + "/" + "finance_db_master.xlsm";


    //@Scheduled(fixedDelay = 1000 * 20)
    public void excelReadExcel() throws IOException {
        try {
            String fname = env.getProperty("custom.project.excel.file-path") + "/" + "finance_db_master.xlsm";
            FileInputStream excelFile = new FileInputStream(new File(fname));

            Workbook workbook = new XSSFWorkbook(excelFile);
            //Workbook workbook = new XSSFWorkbook(fs);
            Sheet datatypeSheet = workbook.getSheetAt(0);
            int numberOfSheets = workbook.getNumberOfSheets();
            Iterator<Row> iterator = datatypeSheet.iterator();

            String sheetName = workbook.getSheetName(0);
            workbook.getAllNames();

            System.out.println("numberOfSheets: " + numberOfSheets);
            System.out.println("sheetName: " + sheetName);
            while (iterator.hasNext()) {
                Row currentRow = iterator.next();

                for (Cell currentCell : currentRow) {
                    //getCellTypeEnum shown as deprecated for version 3.15
                    //getCellTypeEnum ill be renamed to getCellType starting from version 4.0
                    if (currentCell.getCellType() == CellType.STRING) {
                        System.out.print(currentCell.getStringCellValue() + "--");
                    } else if (currentCell.getCellType() == CellType.NUMERIC) {
                        System.out.print(currentCell.getNumericCellValue() + "--");
                    }
                }
                System.out.println();

            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
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

        //String sheetName = workbook.getSheetName(0);
        //workbook.getAllNames();
          Map<String,Integer> sheetMap = new HashMap<>();
        for (int idx = 0; idx < workbook.getNumberOfSheets(); idx++) {
            if( (workbook.getSheetName(idx).contains("_brian")) || (workbook.getSheetName(idx).contains("_kari")) ) {
                System.out.println("Sheet name: " + workbook.getSheetName(idx));
                sheetMap.put(workbook.getSheetName(idx), idx);
                this.printSheet(workbook, idx);
            }
        }

        } catch( FileNotFoundException e) {
            e.printStackTrace();
        }
    }

    private void printSheet(Workbook workbook, int sheetNumber) {
        Sheet datatypeSheet = workbook.getSheetAt(sheetNumber);
        //int numberOfSheets = workbook.getNumberOfSheets();
        for (Row currentRow : datatypeSheet) {

            for (Cell currentCell : currentRow) {
                if (currentCell.getCellType() == CellType.STRING) {
                    System.out.print(currentCell.getStringCellValue() + "--");
                } else if (currentCell.getCellType() == CellType.NUMERIC) {
                    System.out.print(currentCell.getNumericCellValue() + "--");
                }
            }
            System.out.println();
        }
    }
}
