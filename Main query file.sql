-- 2) What are the total number of seats available for elections in each state?

select 
s.state as state_name,
count(cr.parliament_constituency) as total_seats
from
constituencywise_results cr
inner join
statewise_results sr on sr.Parliament_Constituency=cr.Parliament_Constituency
inner join
states s on s.State_ID=sr.State_ID
group by
s.state;

--3) What are the total number of seats won by NDA Alliance?

select
sum(case
       when party in(
	         'Bharatiya Janata Party - BJP',
			 'Telugu Desam - TDP',
			 'Janata Dal  (United) - JD(U)',
			 'Shiv Sena - SHS',
			 'AJSU Party - AJSUP',
			 'Apna Dal (Soneylal) - ADAL',
			 'Asom Gana Parishad - AGP',
			 'Hindustani Awam Morcha (Secular) - HAMS',
			 'Janasena Party - JnP',
			 'Janata Dal  (Secular) - JD(S)',
			 'Lok Janshakti Party(Ram Vilas) - LJPRV',
			 'Nationalist Congress Party - NCP',
			 'Rashtriya Lok Dal - RLD',
			 'Sikkim Krantikari Morcha - SKM'
			 ) then [Won]
			 else 0
		end) as NDA_total_seats_won
from
partywise_results;

--4) Seats won by NDA Alliance Parties
select
party as party_name,
won as seats_won
from 
partywise_results
where party in(
	         'Bharatiya Janata Party - BJP',
			 'Telugu Desam - TDP',
			 'Janata Dal  (United) - JD(U)',
			 'Shiv Sena - SHS',
			 'AJSU Party - AJSUP',
			 'Apna Dal (Soneylal) - ADAL',
			 'Asom Gana Parishad - AGP',
			 'Hindustani Awam Morcha (Secular) - HAMS',
			 'Janasena Party - JnP',
			 'Janata Dal  (Secular) - JD(S)',
			 'Lok Janshakti Party(Ram Vilas) - LJPRV',
			 'Nationalist Congress Party - NCP',
			 'Rashtriya Lok Dal - RLD',
			 'Sikkim Krantikari Morcha - SKM'
			 ) 
order by seats_won desc;

--5) Total seats won by INDIA Alliance

select sum(case 
	  when party in(
	  'Indian National Congress - INC',
	  'Samajwadi Party - SP',
	  'All India Trinamool Congress - AITC',
	  'Dravida Munnetra Kazhagam - DMK',
	  'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
	  'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
	  'Rashtriya Janata Dal - RJD',
	  'Aam Aadmi Party - AAAP',
	  'Jharkhand Mukti Morcha - JMM',
	  'Communist Party of India  (Marxist) - CPI(M)',
	  'Indian Union Muslim League - IUML',
	  'Jammu & Kashmir National Conference - JKN',
	  'Communist Party of India - CPI',
	  'Kerala Congress - KEC',
	  'Viduthalai Chiruthaigal Katchi - VCK',
	  'Revolutionary Socialist Party - RSP',
	  'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
	  'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
	  'Bharat Adivasi Party - BHRTADVSIP',
	  'Rashtriya Loktantrik Party - RLTP'
	  ) then [won]
	  else 0
	end) as INDIA_total_seats_won from partywise_results;
	  
--6) What are the seats won by INDIA Alliance Parties?

select party as Party_name,won as Seats_won
frompartywise_results
where party in(
	  'Indian National Congress - INC',
	  'Samajwadi Party - SP',
	  'All India Trinamool Congress - AITC',
	  'Dravida Munnetra Kazhagam - DMK',
	  'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
	  'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
	  'Rashtriya Janata Dal - RJD',
	  'Aam Aadmi Party - AAAP',
	  'Jharkhand Mukti Morcha - JMM',
	  'Communist Party of India  (Marxist) - CPI(M)',
	  'Indian Union Muslim League - IUML',
	  'Jammu & Kashmir National Conference - JKN',
	  'Communist Party of India - CPI',
	  'Kerala Congress - KEC',
	  'Viduthalai Chiruthaigal Katchi - VCK',
	  'Revolutionary Socialist Party - RSP',
	  'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
	  'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
	  'Bharat Adivasi Party - BHRTADVSIP',
	  'Rashtriya Loktantrik Party - RLTP'
	  ) 
order by Seats_won desc;

--7) Add a new column field in table Partywise_results to get the Party Alliance as NDA, INDIA and other.

alter table partywise_results
add party_alliance varchar(50);

update partywise_results
set party_alliance = 'I.N.D.I.A'
where party in(
	  'Indian National Congress - INC',
	  'Samajwadi Party - SP',
	  'All India Trinamool Congress - AITC',
	  'Dravida Munnetra Kazhagam - DMK',
	  'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
	  'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
	  'Rashtriya Janata Dal - RJD',
	  'Aam Aadmi Party - AAAP',
	  'Jharkhand Mukti Morcha - JMM',
	  'Communist Party of India  (Marxist) - CPI(M)',
	  'Indian Union Muslim League - IUML',
	  'Jammu & Kashmir National Conference - JKN',
	  'Communist Party of India - CPI',
	  'Kerala Congress - KEC',
	  'Viduthalai Chiruthaigal Katchi - VCK',
	  'Revolutionary Socialist Party - RSP',
	  'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
	  'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
	  'Bharat Adivasi Party - BHRTADVSIP',
	  'Rashtriya Loktantrik Party - RLTP'
	  );

update partywise_results
set party_alliance= 'NDA'
where party in(
		'Bharatiya Janata Party - BJP',
			 'Telugu Desam - TDP',
			 'Janata Dal  (United) - JD(U)',
			 'Shiv Sena - SHS',
			 'AJSU Party - AJSUP',
			 'Apna Dal (Soneylal) - ADAL',
			 'Asom Gana Parishad - AGP',
			 'Hindustani Awam Morcha (Secular) - HAMS',
			 'Janasena Party - JnP',
			 'Janata Dal  (Secular) - JD(S)',
			 'Lok Janshakti Party(Ram Vilas) - LJPRV',
			 'Nationalist Congress Party - NCP',
			 'Rashtriya Lok Dal - RLD',
			 'Sikkim Krantikari Morcha - SKM'
			 );

update partywise_results
set party_alliance='Others'
where party_alliance is NULL;

select * from partywise_results;

--8) Which party alliance(NDA,INDIA or other) won the most seats across all states?

select party_alliance,
sum(won) as seats_won
from partywise_results
group by party_alliance
order by seats_won desc ;

--9) Show winning candidates name, their party name, total votes and the margin of victory for a specific state and constituency.

select
cr.Winning_Candidate,
pr.party,
cr.total_votes,
cr.margin,
s.state,
cr.Constituency_Name
from
constituencywise_results cr inner join partywise_results pr on pr.party_id= cr.party_id
inner join statewise_results sr on sr.Parliament_Constituency=cr.Parliament_Constituency
inner join states s on s.state_id=sr.state_id
where cr.Constituency_Name= 'AGRA';

use Indian Elections 2024;
--10) Which parties won the most seats in state and how many seats did each party win?

select
pr.Party,
count(cr.Constituency_ID) as Seats_won
from
constituencywise_results cr
inner join partywise_results pr on cr.Party_ID=pr.Party_ID
inner join statewise_results sr on sr.Parliament_Constituency=pr.Parliament_Constituency
join
states s on sr.State_ID= s.State_ID
where
s.State='Haryana'
group by pr.Party
order by
Seats_won desc;

--11)What is the total number of seats won by each party alliance (NDA, INDIA and Others) in each state
--for the India Elections 2024?

select
s.state,
sum(case when pr.party_alliance='NDA' then 1 else 0 end) as NDA_seats_won,
sum(case when pr.party_alliance='I.N.D.I.A' then 1 else 0 end) as INDIA_seats_won,
sum(case when pr.party_alliance='Others' then 1 else 0 end) as Others_seats_won
from
constituencywise_results cr
inner join partywise_results pr on pr.Party_ID=cr.Party_ID
inner join statewise_results sr on sr.Parliament_Constituency=cr.Parliament_Constituency
inner join states s on sr.State_ID=s.State_ID
group by s.state;

--12) Which candidate received the highest number of EVM votes in each constituency (Top 10)?

select top 10
cr.Constituency_Name,
cd.Constituency_ID,
cd.Candidate,
cd.EVM_Votes
from
constituencywise_details cd
inner join
constituencywise results cr on cd.Constituency_ID=cr.Constituency_ID
where
cd.EVM_Votes=(
	select max(cd1.EVM_Votes)
	from constituencywise_details cd1
	where cd1.Constituency_ID=cd.Constituency_ID)
order by
cd.EVM_Votes desc;


-- 13) Which candidate won and which candidate was the runner up in each constituency of state for the 2024 elections?

with RankedCandidates as (
	select
	cd.Constituency_ID,
	cd.Candidate,
	cd.Party,
	cd.EVM_Votes,
	cd.Postal_Votes,
	cd.EVM_Votes + cd.Postal_Votes as Total_Votes,
	row_number() over (partition by cd.Constituency_ID order by cd.EVM_Votes+ cd.Postal_Votes desc) as VoteRank
	from
	constituencywise_details cd
	join
	constituencywise_results cr on cd.Constituency_ID=cr.Constituency_ID
	join
	statewise_results sr on cr.Parliament_Constituency=sr.Parliament_Constituency
	join
	states s on sr.State_ID=s.State_ID
	where
	s.State= 'Maharashtra'
)
select
	cr.Constituency_Name,
	max(case when rc.VoteRank=1 then rc.Candidate end) as Winning_Candidate,
	max(case when rc.VoteRank=2 then rc.Candidate end) as Runnerup_Candidate
	from
	RankedCandidates rc
	join
	constituency_results cr on rc.Constituency_ID=rc.Constituency_ID
	group by
	cr.Constituency_Name
	order by
	cr.Constituency_Name

--14) Winning candidate's name, their party name, total votes, and the margin of victory
--for a specific state and constituency?

SELECT cr.Winning_Candidate, p.Party, p.party_alliance, cr.Total_Votes, cr.Margin, cr.Constituency_Name, s.State
FROM constituencywise_results cr
JOIN partywise_results p ON cr.Party_ID = p.Party_ID
JOIN statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN states s ON sr.State_ID = s.State_ID
WHERE s.State = 'Uttar Pradesh' AND cr.Constituency_Name = 'AMETHI';

-- 15) For the state of Maharashtra, what are the total number of seats, total number of candidates, 
--total number of parties, total votes(including EVM and Postal),and the breakdown of EVM and Postal votes?

select
COUNT(DISTINCT cr.Constituency_ID) AS Total_Seats,
    COUNT(DISTINCT cd.Candidate) AS Total_Candidates,
    COUNT(DISTINCT p.Party) AS Total_Parties,
    SUM(cd.EVM_Votes + cd.Postal_Votes) AS Total_Votes,
    SUM(cd.EVM_Votes) AS Total_EVM_Votes,
    SUM(cd.Postal_Votes) AS Total_Postal_Votes
FROM 
    constituencywise_results cr
JOIN 
    constituencywise_details cd ON cr.Constituency_ID = cd.Constituency_ID
JOIN 
    statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN 
    states s ON sr.State_ID = s.State_ID
JOIN 
    partywise_results p ON cr.Party_ID = p.Party_ID
WHERE 
    s.State = 'Maharashtra';

