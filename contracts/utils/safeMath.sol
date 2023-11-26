// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity >=0.8.0;

import "./errors.sol";
import "./LibMathErrors.sol";

library LibSafeMath {
    function safeMul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        if (c / a != b) {
            Errors.rrevert(
                LibMathRichErrors.Uint256BinOpError(LibMathRichErrors.BinOpErrorCodes.MULTIPLICATION_OVERFLOW, a, b)
            );
        }
        return c;
    }

    function safeDiv(uint256 a, uint256 b) internal pure returns (uint256) {
        if (b == 0) {
            Errors.rrevert(
                LibMathRichErrors.Uint256BinOpError(LibMathRichErrors.BinOpErrorCodes.DIVISION_BY_ZERO, a, b)
            );
        }
        uint256 c = a / b;
        return c;
    }

    function safeSub(uint256 a, uint256 b) internal pure returns (uint256) {
        if (b > a) {
            Errors.rrevert(
                LibMathRichErrors.Uint256BinOpError(LibMathRichErrors.BinOpErrorCodes.SUBTRACTION_UNDERFLOW, a, b)
            );
        }
        return a - b;
    }

    function safeAdd(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        if (c < a) {
            Errors.rrevert(
                LibMathRichErrors.Uint256BinOpError(LibMathRichErrors.BinOpErrorCodes.ADDITION_OVERFLOW, a, b)
            );
        }
        return c;
    }

    function max256(uint256 a, uint256 b) internal pure returns (uint256) {
        return a >= b ? a : b;
    }

    function min256(uint256 a, uint256 b) internal pure returns (uint256) {
        return a < b ? a : b;
    }

    function safeMul128(uint128 a, uint128 b) internal pure returns (uint128) {
        if (a == 0) {
            return 0;
        }
        uint128 c = a * b;
        if (c / a != b) {
            Errors.rrevert(
                LibMathRichErrors.Uint256BinOpError(LibMathRichErrors.BinOpErrorCodes.MULTIPLICATION_OVERFLOW, a, b)
            );
        }
        return c;
    }

    function safeDiv128(uint128 a, uint128 b) internal pure returns (uint128) {
        if (b == 0) {
            Errors.rrevert(
                LibMathRichErrors.Uint256BinOpError(LibMathRichErrors.BinOpErrorCodes.DIVISION_BY_ZERO, a, b)
            );
        }
        uint128 c = a / b;
        return c;
    }

    function safeSub128(uint128 a, uint128 b) internal pure returns (uint128) {
        if (b > a) {
            Errors.rrevert(
                LibMathRichErrors.Uint256BinOpError(LibMathRichErrors.BinOpErrorCodes.SUBTRACTION_UNDERFLOW, a, b)
            );
        }
        return a - b;
    }

    function safeAdd128(uint128 a, uint128 b) internal pure returns (uint128) {
        uint128 c = a + b;
        if (c < a) {
            Errors.rrevert(
                LibMathRichErrors.Uint256BinOpError(LibMathRichErrors.BinOpErrorCodes.ADDITION_OVERFLOW, a, b)
            );
        }
        return c;
    }

    function max128(uint128 a, uint128 b) internal pure returns (uint128) {
        return a >= b ? a : b;
    }

    function min128(uint128 a, uint128 b) internal pure returns (uint128) {
        return a < b ? a : b;
    }

    function safeDowncastToUint128(uint256 a) internal pure returns (uint128) {
        if (a > type(uint128).max) {}
        return uint128(a);
    }
}
