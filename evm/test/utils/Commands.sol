// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.0;

import {Engine} from "src/core/Engine.sol";

function createCommand(
    address token0,
    address token1,
    uint8 scalingFactor,
    int24 strikeInitial
)
    pure
    returns (Engine.CommandInput memory commandInput)
{
    return Engine.CommandInput(
        Engine.Commands.CreatePair, abi.encode(Engine.CreatePairParams(token0, token1, scalingFactor, strikeInitial))
    );
}

function borrowLiquidityCommand(
    address token0,
    address token1,
    uint8 scalingFactor,
    int24 strike,
    Engine.TokenSelector selectorCollateral,
    uint256 amountDesiredCollateral,
    uint128 amountDesiredDebt
)
    pure
    returns (Engine.CommandInput memory commandInput)
{
    return Engine.CommandInput(
        Engine.Commands.BorrowLiquidity,
        abi.encode(
            Engine.BorrowLiquidityParams(
                token0, token1, scalingFactor, strike, selectorCollateral, amountDesiredCollateral, amountDesiredDebt
            )
        )
    );
}

function repayLiquidityCommand(
    address token0,
    address token1,
    uint8 scalingFactor,
    int24 strike,
    Engine.TokenSelector selectorCollateral,
    uint128 amountDesired
)
    pure
    returns (Engine.CommandInput memory commandInput)
{
    return Engine.CommandInput(
        Engine.Commands.RepayLiquidity,
        abi.encode(
            Engine.RepayLiquidityParams(token0, token1, scalingFactor, strike, selectorCollateral, amountDesired)
        )
    );
}

function addLiquidityCommand(
    address token0,
    address token1,
    uint8 scalingFactor,
    int24 strike,
    uint8 spread,
    uint128 amountDesired
)
    pure
    returns (Engine.CommandInput memory commandInput)
{
    return Engine.CommandInput(
        Engine.Commands.AddLiquidity,
        abi.encode(Engine.AddLiquidityParams(token0, token1, scalingFactor, strike, spread, amountDesired))
    );
}

function removeLiquidityCommand(
    address token0,
    address token1,
    uint8 scalingFactor,
    int24 strike,
    uint8 spread,
    uint128 amountDesired
)
    pure
    returns (Engine.CommandInput memory commandInput)
{
    return Engine.CommandInput(
        Engine.Commands.RemoveLiquidity,
        abi.encode(Engine.RemoveLiquidityParams(token0, token1, scalingFactor, strike, spread, amountDesired))
    );
}

function swapCommand(
    address token0,
    address token1,
    uint8 scalingFactor,
    Engine.SwapTokenSelector selector,
    int256 amountDesired
)
    pure
    returns (Engine.CommandInput memory commandInput)
{
    return Engine.CommandInput(
        Engine.Commands.Swap, abi.encode(Engine.SwapParams(token0, token1, scalingFactor, selector, amountDesired))
    );
}

function createCommandInput() pure returns (Engine.CommandInput[] memory) {
    return new Engine.CommandInput[](0);
}

function pushCommandInputs(
    Engine.CommandInput[] memory commandInputs,
    Engine.CommandInput memory commandInput
)
    pure
    returns (Engine.CommandInput[] memory)
{
    Engine.CommandInput[] memory newCommands = new Engine.CommandInput[](commandInputs.length +1);

    for (uint256 i = 0; i < commandInputs.length; i++) {
        newCommands[i] = commandInputs[i];
    }

    newCommands[commandInputs.length] = commandInput;

    return newCommands;
}
