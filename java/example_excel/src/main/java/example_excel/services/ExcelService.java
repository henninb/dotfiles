package example_excel.services;

import org.apache.poi.poifs.crypt.Decryptor;
import org.apache.poi.poifs.crypt.EncryptionInfo;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.io.*;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

@Service
public class ExcelService {
    //private static final String FILE_NAME = "/tmp/example.xlsx";
    //private static final String FILE_NAME = "/Users/z037640/test.xlsx";
    private static final String FILE_NAME = "/Users/z037640/finance_db_master_stage_2019_09_27-07-09.xlsm";
    //private final Logger LOGGER = LoggerFactory.getLogger(this.getClass());

    //@Scheduled(fixedDelay = 1000 * 20)
    public void excelReadExcel() {
        try {
            FileInputStream excelFile = new FileInputStream(new File(FILE_NAME));

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
                Iterator<Cell> cellIterator = currentRow.iterator();

                while (cellIterator.hasNext()) {
                    Cell currentCell = cellIterator.next();
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
        } catch (IOException e) {
            e.printStackTrace();
        }
//        catch (InvalidFormatException ife) {
//            ife.printStackTrace();
//        }
    }

    @Scheduled(fixedDelay = 1000 * 20)
    public void readPasswordProtected() throws Exception {
      try {
        POIFSFileSystem fs = new POIFSFileSystem(new FileInputStream(FILE_NAME));
        EncryptionInfo info = new EncryptionInfo(fs);

        Decryptor decryptor = Decryptor.getInstance(info);
        decryptor.verifyPassword("changeit");

        InputStream is = decryptor.getDataStream(fs);

        Workbook workbook = new XSSFWorkbook(is);

        //String sheetName = workbook.getSheetName(0);
        //workbook.getAllNames();
          Map<String,Integer> sheetMap = new HashMap<String,Integer>();
        for (int idx = 0; idx < workbook.getNumberOfSheets(); idx++) {
            if( (workbook.getSheetName(idx).contains("_brian")) || (workbook.getSheetName(idx).contains("_kari")) ) {
                System.out.println("Sheet name: " + workbook.getSheetName(idx));
                sheetMap.put(workbook.getSheetName(idx), idx);
                this.printSheet(workbook, idx);
            }
        }

        } catch( FileNotFoundException e) {
            e.printStackTrace();
        }  catch( IOException e) {
            e.printStackTrace();
        }
    }

    private void printSheet(Workbook workbook, int sheetNumber) {
        Sheet datatypeSheet = workbook.getSheetAt(sheetNumber);
        //int numberOfSheets = workbook.getNumberOfSheets();
        Iterator<Row> iterator = datatypeSheet.iterator();
        while (iterator.hasNext()) {
            Row currentRow = iterator.next();
            Iterator<Cell> cellIterator = currentRow.iterator();

            while (cellIterator.hasNext()) {
                Cell currentCell = cellIterator.next();
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
