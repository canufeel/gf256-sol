pragma solidity 0.5.7;


library GF256 {
    function _exp(uint8 idx) private pure returns (uint8) {
        uint8 row = idx / 32;
        uint256 shiftBits;
        uint256 rowData;
        assembly {
            shiftBits := mul(sub(31, sub(idx, mul(row, 32))), 8)
            switch row
            case 0 { rowData := 0x0103050f113355ff1a2e7296a1f813355fe13848d87395a4f702060a1e2266aa }
            case 1 { rowData := 0xe5345ce43759eb266abed97090abe63153f5040c143c44cc4fd168b8d36eb2cd }
            case 2 { rowData := 0x4cd467a9e03b4dd762a6f10818287888839eb9d06bbddc7f8198b3ce49db769a }
            case 3 { rowData := 0xb5c457f9103050f00b1d2769bbd661a3fe192b7d8792adec2f7193aee92060a0 }
            case 4 { rowData := 0xfb163a4ed26db7c25de73256fa153f41c35ee23d47c940c05bed2c749cbfda75 }
            case 5 { rowData := 0x9fbad564acef2a7e829dbcdf7a8e89809bb6c158e82365afea256fb1c843c554 }
            case 6 { rowData := 0xfc1f2163a5f407091b2d7799b0cb46ca45cf4ade798b8691a8e33e42c651f30e }
            case 7 { rowData := 0x12365aee297b8d8c8f8a8594a7f20d17394bdd7c8497a2fd1c246cb4c752f601 }
        }
        return uint8((rowData & (uint256(0xff) << shiftBits)) >> shiftBits);
    }

    function _log(uint8 idx) private pure returns (uint8) {
        uint8 row = idx / 32;
        uint256 shiftBits;
        uint256 rowData;
        assembly {
            shiftBits := mul(sub(31, sub(idx, mul(row, 32))), 8)
            switch row
            case 0 { rowData := 0x0000190132021ac64bc71b6833eedf036404e00e348d81ef4c7108c8f8691cc1 }
            case 1 { rowData := 0x7dc21db5f9b9276a4de4a6729ac90978652f8a05210fe12412f082453593da8e }
            case 2 { rowData := 0x968fdbbd36d0ce94135cd2f14046833866ddfd30bf068b62b325e29822889110 }
            case 3 { rowData := 0x7e6e48c3a3b61e423a6b2854fa853dba2b790a159b9f5eca4ed4ace5f373a757 }
            case 4 { rowData := 0xaf58a850f4ead6744faee9d5e7e6ade82cd7757aeb160bf559cb5fb09ca951a0 }
            case 5 { rowData := 0x7f0cf66f17c449ecd8431f2da4767bb7ccbb3e5afb60b1863b52a16caa55299d }
            case 6 { rowData := 0x97b2879061bedcfcbc95cfcd373f5bd15339843c41a26d47142a9e5d56f2d3ab }
            case 7 { rowData := 0x441192d923202e89b47cb8267799e3a5674aeddec531fe180d638c80c0f77007 }
        }
        return uint8((rowData & (uint256(0xff) << shiftBits)) >> shiftBits);
    }

    function gf256Add(uint8 a, uint8 b) internal pure returns (uint8) {
        return a ^ b;
    }

    function gf256Sub(uint8 a, uint8 b) internal pure returns (uint8) {
        return gf256Add(a, b);
    }

    function gf256Mul(uint8 a, uint8 b) internal pure returns (uint8) {
        if (a == 0 && b == 0) {
            return 0;
        } else {
            uint16 aLog = uint16(_log(a));
            uint16 bLog = uint16(_log(b));
            return _exp(uint8((aLog + bLog) % 255));
        }
    }

    function gf256Div(uint8 a, uint8 b) internal pure returns (uint8) {
        assert(b != 0);
        if (a == 0) {
            return 0;
        } else {
            uint8 aLog = _log(a);
            uint8 bLog = _log(b);
            uint8 diff;
            if (aLog < bLog) {
                diff = 255 + aLog - bLog;
            } else {
                diff = aLog - bLog;
            }
            return _exp(diff);
        }
    }
}
