
// Generated by MyGeneration Version # (1.3.0.3)

using System;
using DAL;
using System.Collections.Specialized;
using System.Data;
using System.Data.SqlClient;

namespace BLL
{
	public class SportClubMembers : _SportClubMembers
	{
		public SportClubMembers()
		{
		
		}

        public bool SearchMember(string Name)
        {
            string query = string.Format(@"
            Select S.SportClubMembersID ID , S.MemberName Name , L.LevelName Fitness , L2.LevelName Speed , L3.LevelName Tallness , L4.LevelName Weight
            From SportClubMembers S
            inner join Levels L on S.MemberFitness = L.LevelID 
            inner join Levels L2 on S.MemberSpeed = L2.LevelID 
            inner join Levels L3 on S.MemberTallness = L3.LevelID 
            inner join Levels L4 on S.MemberWeight = L4.LevelID 
            where S.MemberName like '%{0}%'",Name);

            //ListDictionary paramaters = new ListDictionary();
            //paramaters.Add(new SqlParameter("@MemberName", SqlDbType.Text), Name);
            return LoadFromRawSql(query);
        }
    }
}
