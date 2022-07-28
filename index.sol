// SPDX-License-Identifier: MIT
pragma solidity 0.6.2;
import "https://github.com/Uniswap/uniswap-v2-periphery/blob/master/contracts/interfaces/IUniswapV2Router02.sol";
interface IERC20 {
    function totalSupply() external view returns (uint);
    function balanceOf(address account) external view returns (uint);
    function transfer(address recipient, uint amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint);
    function approve(address spender, uint amount) external returns (bool);
    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}




// import"https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

// import ".interfaces/Uniswap.sol";

contract A {
     IUniswapV2Router02 public uniswapRouter;
address payable private TokenA_address = 0x8379e73E7b481E01DBb0065744FbE35dc7355A59; 
address payable private TokenB_address = 0xAc71e900C0eCe604E2b3c5b275c0c432D974089B;
address private constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
address internal constant UNISWAP_V2_ROUTER = 0x1e4F3ED087165B278448DD4b4f23F14071b81672 ;
event Received(address, uint);
constructor  () public {
    uniswapRouter = IUniswapV2Router02(UNISWAP_V2_ROUTER);
}
function SendEther (address payable _to) external payable{
    _to.transfer(msg.value);
}
// uint public receivedEther;
    receive () external payable{
        emit Received(msg.sender , msg.value);
        
        // }
    }

function convertEthIntoTheTokens(address payable TokenA_address,address payable TokenB_address,uint amountAin,uint AmountBin, uint TokenAamountOutmin, uint TokenBamountOutmin) public payable {  //, address TokenA_address, address TokenB_address, uint amountA , uint amountB
  uint deadline = block.timestamp +15;    
//   if(msg.value>0){
 uniswapRouter.swapExactETHForTokens  {value: (msg.value/2)} (TokenAamountOutmin,getPathtoEthToTokenA(), address(this), deadline);

//   IERC20( TokenA_address).balanceOf(address(this));
 uniswapRouter.swapExactETHForTokens  {value: (address(this).balance)} (TokenBamountOutmin,getPathEthToTokenB(), address(this), deadline);
// address(this).balance;
// getbalance();
// uniswapRouter.addLiquidity()
IERC20(TokenA_address).transferFrom(msg.sender, address(this), amountAin);
IERC20(TokenB_address).transferFrom(msg.sender, address(this), AmountBin);

IERC20(TokenA_address).approve(0x1e4F3ED087165B278448DD4b4f23F14071b81672, amountAin);
IERC20(TokenB_address).approve(0x1e4F3ED087165B278448DD4b4f23F14071b81672, AmountBin);
uniswapRouter.addLiquidity(TokenA_address, TokenB_address, amountAin, AmountBin,TokenAamountOutmin,TokenBamountOutmin, address(msg.sender), block.timestamp);

}

function getPathtoEthToTokenA( )  private view returns(address [] memory){

    address[] memory path = new address[](2);
    path[0] = uniswapRouter.WETH();
    path[1] = TokenA_address;
    return path;



}
 function getPathEthToTokenB() private view returns (address [] memory){
         address[] memory path = new address[](2);
    path[0] = uniswapRouter.WETH();
    path[1] = TokenB_address;
    return path;

     
 }
 function getAmountsOutA(uint amountin ) public view returns (uint[] memory) {
return uniswapRouter.getAmountsOut(amountin , getPathtoEthToTokenA());
 }
  function getAmountsOutB(uint amountin ) public view returns (uint[] memory) {
return uniswapRouter.getAmountsOut(amountin , getPathEthToTokenB());
 }




function getbalance() public view returns   (uint256){
    return address(this).balance;
  }

   

   
   

}