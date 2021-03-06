// Copyright (c) 2018 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

# Spreadsheet object.
# + spreadsheetId - Id of the spreadsheet
# + properties - Properties of a spreadsheet
# + sheets - The sheets that are part of a spreadsheet
# + spreadsheetUrl - The URL of the spreadsheet
public type Spreadsheet object {

    public string spreadsheetId;
    public SpreadsheetProperties properties;
    public Sheet[] sheets;
    public string spreadsheetUrl;

    # Get the name of the spreadsheet.
    # + return - Name of the spreadsheet object on success and SpreadsheetError on failure
    public function getSpreadsheetName() returns (string)|SpreadsheetError;

    # Get the Id of the spreadsheet.
    # + return - Id of the spreadsheet object on success and SpreadsheetError on failure
    public function getSpreadsheetId() returns (string)|SpreadsheetError;

    # Get sheets of the spreadsheet.
    # + return - Sheet array on success and SpreadsheetError on failure
    public function getSheets() returns Sheet[]|SpreadsheetError;

    # Get sheets of the spreadsheet.
    # + sheetName - Name of the sheet to retrieve
    # + return - Sheet object on success and SpreadsheetError on failure
    public function getSheetByName(string sheetName) returns Sheet|SpreadsheetError;
};

# Spreadsheet properties.
# + title - The title of the spreadsheet
# + locale - The locale of the spreadsheet
# + autoRecalc - The amount of time to wait before volatile functions are recalculated
# + timeZone - The time zone of the spreadsheet
public type SpreadsheetProperties record {
    string title;
    string locale;
    string autoRecalc;
    string timeZone;
};

# Sheet object.
# + properties - The properties of the sheet
public type Sheet record {
    SheetProperties properties;
};

# Sheet properties.
# + sheetId - The ID of the sheet
# + title - The name of the sheet
# + index - The index of the sheet within the spreadsheet
# + sheetType - The type of sheet
# + gridProperties - Additional properties of the sheet if this sheet is a grid
# + hidden - True if the sheet is hidden in the UI, false if it is visible
# + rightToLeft - True if the sheet is an RTL sheet instead of an LTR sheet
public type SheetProperties record {
    int sheetId;
    string title;
    int index;
    string sheetType;
    GridProperties gridProperties;
    boolean hidden;
    boolean rightToLeft;
};

# Grid properties.
# + rowCount - The number of rows in the grid
# + columnCount - The number of columns in the grid
# + frozenRowCount - The number of rows that are frozen in the grid
# + frozenColumnCount - The number of columns that are frozen in the grid
# + hideGridlines - True if the grid is not showing gridlines in the UI
public type GridProperties record {
    int rowCount;
    int columnCount;
    int frozenRowCount;
    int frozenColumnCount;
    boolean hideGridlines;
};

# Spreadsheet error.
# + message - Error message
# + cause - The error which caused the Spreadsheet error
# + statusCode - The status code
public type SpreadsheetError record {
    string message;
    error? cause;
    int statusCode;
};

//Functions binded to Spreadsheet struct
function Spreadsheet::getSpreadsheetName() returns (string)|SpreadsheetError {
    SpreadsheetError spreadsheetError = {};
    string title = "";
    if (self.properties == null) {
        spreadsheetError.message = "Spreadsheet properties cannot be null";
        return spreadsheetError;
    } else {
        return self.properties.title;
    }
}

function Spreadsheet::getSpreadsheetId() returns (string)|SpreadsheetError {
    SpreadsheetError spreadsheetError = {};
    string spreadsheetId = "";
    if (self.spreadsheetId == null) {
        spreadsheetError.message = "Unable to find the spreadsheet id";
        return spreadsheetError;
    }
    return self.spreadsheetId;
}

function Spreadsheet::getSheets() returns Sheet[]|SpreadsheetError {
    SpreadsheetError spreadsheetError = {};
    if (self.sheets == null) {
        spreadsheetError.message = "No sheets found";
        return spreadsheetError;
    }
    return self.sheets;
}

function Spreadsheet::getSheetByName(string sheetName) returns Sheet|SpreadsheetError {
    Sheet[] sheets = self.sheets;
    Sheet sheetResponse = {};
    SpreadsheetError spreadsheetError = {};
    if (sheets == null) {
        spreadsheetError.message = "No sheet found";
        return spreadsheetError;
    } else {
        foreach sheet in sheets {
            if (sheet.properties != null) {
                if (sheet.properties.title.equalsIgnoreCase(sheetName)) {
                    sheetResponse = sheet;
                    break;
                }
            }
        }
        return sheetResponse;
    }
}
