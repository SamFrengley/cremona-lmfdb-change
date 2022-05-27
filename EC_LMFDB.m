freeze;

HERE_IS_ecdata := "THIS NEEDS TO BE FILLED IN";

function CorrespondenceFile(conductor)
    low := 10000*Floor(conductor/10000);
    high := low + 9999;
    if low eq 0 then
        low := "00000";
        high := "09999";
    else 
        low := IntegerToString(low);
        high := IntegerToString(high);
    end if;

    str := HERE_IS_ecdata cat "alllabels." cat low cat "-" cat high;
    return str;
end function;

function AllCoorespondence(conductor)
    file := Read(CorrespondenceFile(conductor));
    cor := Split(file, "\n");
    cor := [Split(str, " ") : str in cor];
    cor := [<&cat s[1..3], s[4] cat "." cat s[5] cat s[6]> : s in cor];
    return cor;
end function;

function Correspondence(label)
    if "." in label then
        cor := AllCoorespondence(StringToInteger(Split(label, ".")[1]));
        i := Index([c[2] : c in cor], label);
        assert cor[i][2] eq label;
        return cor[i][1];
    
    else 
        cond := label[1..Min([i : i in [1..#label] | not (label[i] in ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"])])-1];
        cor := AllCoorespondence(StringToInteger(cond));
        i := Index([c[1] : c in cor], label);
        assert cor[i][1] eq label;
        return cor[i][2];
    end if;
end function;

intrinsic CremonaLabel(E::CrvEll) -> MonStgElt
{Cremona label because I always forget that it is reference}
    return CremonaReference(E);
end intrinsic;

intrinsic LMFDBLabel(E::CrvEll) -> MonStgElt
{Returns the LMFDB label of E}
    crem := CremonaReference(E);
    return Correspondence(crem);
end intrinsic;

intrinsic EllipticCurveLMFDB(str::MonStgElt) -> CrvEll
{Give me an elliptic curve}
    crem := Correspondence(str);
    return EllipticCurve(crem);
end intrinsic;