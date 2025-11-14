// Mapping of CNP county codes to county names
export const cnpCountyMap: Record<string, string> = {
  "01": "Alba",
  "02": "Arad",
  "03": "Argeș",
  "04": "Bacău",
  "05": "Bihor",
  "06": "Bistrița-Năsăud",
  "07": "Botoșani",
  "08": "Brașov",
  "09": "Brăila",
  "10": "Buzău",
  "11": "Caraș-Severin",
  "12": "Cluj",
  "13": "Constanța",
  "14": "Covasna",
  "15": "Dâmbovița",
  "16": "Dolj",
  "17": "Galați",
  "18": "Gorj",
  "19": "Harghita",
  "20": "Hunedoara",
  "21": "Ialomița",
  "22": "Iași",
  "23": "Ilfov",
  "24": "Maramureș",
  "25": "Mehedinți",
  "26": "Mureș",
  "27": "Neamț",
  "28": "Olt",
  "29": "Prahova",
  "30": "Satu-Mare",
  "31": "Sălaj",
  "32": "Sibiu",
  "33": "Suceava",
  "34": "Teleorman",
  "35": "Timiș",
  "36": "Tulcea",
  "37": "Vaslui",
  "38": "Vâlcea",
  "39": "Vrancea",
  "40": "București",
  "41": "București - Sector 1",
  "42": "București - Sector 2",
  "43": "București - Sector 3",
  "44": "București - Sector 4",
  "45": "București - Sector 5",
  "46": "București - Sector 6",
  "51": "Călărași",
  "52": "Giurgiu",
};

// Validate CNP check digit
export const validateCnpCheckDigit = (cnp: string): boolean => {
  const controlNumber = "279146358279";
  let sum = 0;
  
  for (let i = 0; i < 12; i++) {
    sum += parseInt(cnp[i]) * parseInt(controlNumber[i]);
  }
  
  const remainder = sum % 11;
  const checkDigit = remainder === 10 ? 1 : remainder;
  
  return checkDigit === parseInt(cnp[12]);
};

// Extract county from CNP
export const getCountyFromCnp = (cnp: string): string | null => {
  const countyCode = cnp.substring(7, 9);
  return cnpCountyMap[countyCode] || null;
};

// Map county codes from CNP to town codes used in the app
export const getTownCodeFromCnpCounty = (cnp: string): string | null => {
  const countyCode = cnp.substring(7, 9);
  
  // București and all sectors map to BUC01
  if (["40", "41", "42", "43", "44", "45", "46"].includes(countyCode)) {
    return "BUC01";
  }
  
  // Map all counties to their main cities - for counties not in towns list, map to nearest major city
  const countyToTownMap: Record<string, string> = {
    "01": "SBU01", // Alba -> Sibiu (nearest major city)
    "02": "TIM01", // Arad -> Timișoara
    "03": "PTI01", // Argeș -> Pitești
    "04": "BCU01", // Bacău -> Bacău
    "05": "ORD01", // Bihor -> Oradea
    "06": "CLJ01", // Bistrița-Năsăud -> Cluj-Napoca
    "07": "BTU01", // Botoșani -> Botoșani
    "08": "BRS01", // Brașov -> Brașov
    "09": "GLT01", // Brăila -> Galați
    "10": "BZU01", // Buzău -> Buzău
    "11": "TIM01", // Caraș-Severin -> Timișoara
    "12": "CLJ01", // Cluj -> Cluj-Napoca
    "13": "CTA01", // Constanța -> Constanța
    "14": "BRS01", // Covasna -> Brașov
    "15": "PTI01", // Dâmbovița -> Pitești
    "16": "CRV01", // Dolj -> Craiova
    "17": "GLT01", // Galați -> Galați
    "18": "CRV01", // Gorj -> Craiova
    "19": "BRS01", // Harghita -> Brașov
    "20": "TIM01", // Hunedoara -> Timișoara
    "21": "BUC01", // Ialomița -> București
    "22": "IAS01", // Iași -> Iași
    "23": "BUC01", // Ilfov -> București
    "24": "BAI01", // Maramureș -> Baia Mare
    "25": "CRV01", // Mehedinți -> Craiova
    "26": "TGM01", // Mureș -> Târgu Mureș
    "27": "IAS01", // Neamț -> Iași
    "28": "CRV01", // Olt -> Craiova
    "29": "PLO01", // Prahova -> Ploiești
    "30": "STU01", // Satu Mare -> Satu Mare
    "31": "CLJ01", // Sălaj -> Cluj-Napoca
    "32": "SBU01", // Sibiu -> Sibiu
    "33": "SUC01", // Suceava -> Suceava
    "34": "BUC01", // Teleorman -> București
    "35": "TIM01", // Timiș -> Timișoara
    "36": "CTA01", // Tulcea -> Constanța
    "37": "IAS01", // Vaslui -> Iași
    "38": "RMV01", // Vâlcea -> Râmnicu Vâlcea
    "39": "GLT01", // Vrancea -> Galați
    "51": "BUC01", // Călărași -> București
    "52": "BUC01", // Giurgiu -> București
  };
  
  return countyToTownMap[countyCode] || null;
};
