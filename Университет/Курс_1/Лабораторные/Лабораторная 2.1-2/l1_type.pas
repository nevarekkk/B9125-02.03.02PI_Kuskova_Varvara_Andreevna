unit l1_type;

interface
type 
  date = record
    dd: word;
    mm: word;
    yy: word;
  end;

type 
  abiturient = record
    snils: string;
    data_bir: date;
    prikaz: string;
    data_prikaz: date;
    cod_post: string;
    sum_ege: word;
  end;
  
const n = 1000;
type 
  abiturients = array[1..n] of abiturient;
implementation

begin
  
end.   