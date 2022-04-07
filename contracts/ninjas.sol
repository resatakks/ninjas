//SPDX-License-Identifier :MIT
pragma solidity ^0.8.7;

import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import '@openzeppelin/contracts/access/Ownable.sol';
contract ninjas is ERC721,Ownable{
uint256 public mintPrice;    // mint ücreti
uint256 public totalSupply;    //satılmış adet sayısını tutacak
uint256 public maxSupply;   //toplam nft sayısı 
uint8 public maxMint;  //max mint hakkı
bool public isMintEnabled;   //public mint başladığı hakkında
string internal baseTokenUri;    //token metadatasını set edicez
mapping(adress=>uint8)public walletMints;  //walletMints['cüzdan adresi']= 2
constructor()payable ERC721('ninjas','Resat'){

    mintPrice=0.01 ether;
    totalSuplly=0;
    maxSupply=1000;
    maxMint=3;
}
function setIsMintEnabled(bool isMintEnabled_)external onlyOwner{   // mint baslangıcı
isMintEnabled=isMintEnabled_;
}              
function setBaseTokenUri(string calldata baseTokenUri_)external onlyOwner{    //metadata
//https://lc2rtjgzig.execute-api.eu-west-1.amazonaws.com/prod/metadata/  
    baseTokenUri=baseTokenUri_;

}
function tokenURI(uint256 tokenId_)public view override returns(string memory){//nftnin adresini alması için
require(_exists(tokenId_),'Token Yok');
require string(abi.encodePacked(baseTokenUri,Strings.tostring(tokenId_)));
//https://lc2rtjgzig.execute-api.eu-west-1.amazonaws.com/prod/metadata/1 
}            
function withdraw()external onlyOwner{
    (bool success,)=msg.sender.call{value:adress(this).balance}("");
    require(success,'para yok withdraw basarisiz');
}
function mint(uint8 quantity_)public payable{   //quantity suan  alınmak istenen adet
    require(isMintEnabled,)'Mint baslamadi'); //0.02 ether== 2 * 0.01
    require(msg.value==quantity_ * mintPrice,'mint ücreti yetersiz');
//1000+2 tane satılamaz
require(totalSupply+quantity_<=maxSupply,'sold out');
require (walletMints[msg.sender]+quantity_<=maxMint,'max adet asildi');

for(uint8 i=0;i<quantity_;i++){
    uint256 newTokenId=totalSupply +1;
    totalSuply++;
    _safeMint(msg.sender,newTokenId);
}
}



}