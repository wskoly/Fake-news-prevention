pragma solidity ^0.4.18;

contract uap 
{
    uint newsCount; //total number of news created
    uint validatorCount; //total number of validator present
    uint VratingCount; //total number of rating given
    address owner; //address of contact owner
    string ok="koly";
    struct news
    {
       uint id;
       string title;
       string message;
       string area;
       uint rating; //summation of rating given to this news
       uint finalRating; //mean rating of this news 
       bool isRated; 
       uint ratingCount; //number of validators that rated this news
    }
    mapping(uint=>news)public newses; //news array
    struct vRatingTrack //track the validator aticivity towqrds a specific news
    {
        uint newsId;
        uint[] vRatingTrack;
    }
    mapping(uint=>vRatingTrack)public vRatingTracker;
    struct validator
    {
        uint id;
        uint pWeight; //validator weight
        string area; //validator area
    }
    mapping(address=>validator)public validators;
    mapping(address=>bool) checkUser; //to check if validator has already rated a particular news
    struct vRating
    {
        uint id;
        uint newsId; //news id
        uint vId; // validator id
        uint areaWeight; //calculated area weight for rating
        uint pRating; // validator given rating
        uint finalRating; //final rating generated 
        address vAddress; //validator address
    }
    mapping(uint=>vRating)public validatorRating;
    function stringToUint(string memory s)internal returns (uint result) 
    {
        bytes memory b = bytes(s);
        uint i;
        result = 0;
        for (i = 0; i < b.length; i++) 
        {
            uint c = uint(uint8(b[i]));
            if (c >= 48 && c <= 57) 
            {
                result = result * 10 + (c - 48);
            }
        }
    }
    constructor()public
    {
        owner=msg.sender;
    }
    modifier koly 
    {
        require(msg.sender==owner);
        _;
    }
    function createValidor(string memory _area) public //function to create a validator
    {
        require(!checkUser[msg.sender]);
        validatorCount++;
        validators[msg.sender]=validator(validatorCount, 10, _area);
        checkUser[msg.sender]=true;
    }
    function createNews(string memory _title, string memory _message, string memory _area) public //function to create a news 
    {
        newsCount++;
        newses[newsCount]=news(newsCount, _title, _message, _area, 0, 0, false, 0);
    }
    function giveRating(string memory _newsID, string memory _personalR) public //function to rate a news 
    {
        uint _newsId = stringToUint(_newsID);
        uint _pRating = stringToUint(_personalR);
        bool ratingDup=false;
        if(validators[msg.sender].pWeight<5)
        {
            ratingDup=true;
        }
        for(uint i=1; i<=VratingCount; i++)
        {
            if((validatorRating[i].newsId == _newsId) && (validatorRating[i].vAddress== msg.sender))
               {ratingDup=true;}
        }
        require(!ratingDup);
        VratingCount++;
        uint _areaWeight=caluculateAreaWeight(newses[_newsId].area, validators[msg.sender].area);
        validatorRating[VratingCount]=vRating(VratingCount, _newsId, validators[msg.sender].id, _areaWeight, _pRating, 0, msg.sender);
        validatorRating[VratingCount].finalRating=vRatingCalculation(VratingCount, msg.sender);
        newses[_newsId].rating+=validatorRating[VratingCount].finalRating;
        newses[_newsId].ratingCount+=1;
         newses[_newsId].isRated=true;
          vRatingTracker[_newsId].newsId=_newsId; vRatingTracker[_newsId].vRatingTrack.push(VratingCount);
        generateNewsRating(_newsId);
    }
    function caluculateAreaWeight(string memory _nArea, string memory _vArea)private pure returns(uint) //function to calcultae area weight
    {
      uint aWeight=2;
      bytes memory n=bytes(_nArea);
      bytes memory v=bytes(_vArea);
      if(n[0]==v[0])
      {
          aWeight+=2;
      }
      if(n[1]==v[1])
      {
          aWeight+=2;
      }
      if(n[2]==v[2])
      {
          aWeight+=2;
      }
      if(n[3]==v[3])
      {
          aWeight+=2;
      }
      return aWeight;
    }
    function vRatingCalculation(uint _id, address _vAddress)private view returns(uint) //function to generate final validator rating
    {
        uint areaRating=validatorRating[_id].areaWeight+validatorRating[_id].pRating;
        areaRating/=2;
        uint finalR=areaRating*validators[_vAddress].pWeight;
        finalR/=10;
        return finalR;
    }
    function generateNewsRating(uint _nId)private //function to generate final news rating
    {
        newses[_nId].finalRating=(newses[_nId].rating/newses[_nId].ratingCount);
    }
    /*function vachek(uint _id, uint _arr)public view returns(uint ratingID)
    {
        return vRatingTracker[_id].vRatingTrack[_arr];
    }*/
    function validatorWeight()public koly //function to generate validator weight only called by contract owner
    {
        for(uint i=1; i<=newsCount; i++)
        {
            for(uint j=0; j<newses[i].ratingCount; j++)
            {
                uint rId=vRatingTracker[i].vRatingTrack[j]; //rating id
                address vAd = validatorRating[rId].vAddress; //validator address
                uint pRating = validatorRating[rId].pRating; //validator personal rating
                uint fRating = validatorRating[rId].finalRating; //validator final rating
                uint nRating = newses[i].finalRating; //news rating
                if(pRating>=(nRating+2) || pRating<=(nRating-2))
                {
                    validators[vAd].pWeight-=1;
                }
                if(fRating>=(nRating+2) || fRating<=(nRating-2))
                {
                    validators[vAd].pWeight-=1;
                }
            }
        }
    }
    function getNewsCount()public view returns(uint)
    {
        return newsCount;
    }
    function getNews(uint _id) public view returns(string memory, string memory, string memory, uint, bool)
    {
        return (newses[_id].title, newses[_id].message, newses[_id].area, newses[_id].finalRating, newses[_id].isRated);
    }
}