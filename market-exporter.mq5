#property copyright "João Escribano"
#property link      "https://github.com/joaoescribano/mql5-exporter"
#property version   "1.00"

int lastIndex;
int file_handle;

int OnInit() {
    string fileNme = Symbol() + ".csv";
    Print("Exported file: ", fileNme);
    file_handle = FileOpen(fileNme, FILE_READ|FILE_WRITE);

    if(file_handle == INVALID_HANDLE) {
        Print("Cannot create ", fileNme, " file.");
        return(INIT_FAILED);
    } else {
        FileWrite(file_handle, "datetime,open,close,low,high,volume,spread");
    }
    
    return(INIT_SUCCEEDED);
}

int OnCalculate(const int rates_total,const int prev_calculated, const datetime &Time[], const double &Open[], const double &High[], const double &Low[], const double &Close[], const long &TickVolume[], const long &Volume[], const int &Spread[]) {
    int actualIndex = Bars(Symbol(), Period());
    if (actualIndex > lastIndex) {
        string datestring = TimeToString(Time[rates_total-2]);
        string finalLine = datestring + "," + Open[rates_total-2] + "," + Close[rates_total-2] + "," + Low[rates_total-2] + "," + High[rates_total-2] + "," + Volume[rates_total-2] + "," + Spread[rates_total-2];
        FileWrite(file_handle, finalLine);
        lastIndex = actualIndex;
    }
    return(rates_total);
}
