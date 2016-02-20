using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Xml;
using System.Xml.Linq;
using WindowsFormsApplication2;

namespace SoftwareEngineeringProject
{
    public partial class MainForm : Form
    {
        public MainForm()
        {
            InitializeComponent();
        }
        private void Form1_Load(object sender, EventArgs e)
        {
            // Load All Members in DataGridView
            MembersGrd.AutoGenerateColumns = false;
            bindMembersGrd();

            //Load All ComboBoxes
            BLL.Levels objDataFitness = new BLL.Levels();
            objDataFitness.LoadAll();
            cbFitness.DataSource = objDataFitness.DefaultView;

            BLL.Levels objDataSpeed = new BLL.Levels();
            objDataSpeed.LoadAll();
            cbSpeed.DataSource = objDataSpeed.DefaultView;

            BLL.Levels objDataTallness = new BLL.Levels();
            objDataTallness.LoadAll();
            cbTalness.DataSource = objDataTallness.DefaultView;

            BLL.Levels objDataWeight = new BLL.Levels();
            objDataWeight.LoadAll();
            cbWeight.DataSource = objDataWeight.DefaultView;
        }
        private void btnReset_Click(object sender, EventArgs e)
        {
            clearFields();
            bindMembersGrd();
        }
        private void bindMembersGrd()
        {
            BLL.SportClubMembers objDataMembers = new BLL.SportClubMembers();
            objDataMembers.SearchMember(txtSearch.Text);
            MembersGrd.DataSource = objDataMembers.DefaultView;
        }
        private void btnSearch_Click(object sender, EventArgs e)
        {
            bindMembersGrd();
        }
        private void btnUpdate_Click(object sender, EventArgs e)
        {
            BLL.SportClubMembers objData = new BLL.SportClubMembers();
            if (Program.currentMember > 0)
                objData.LoadByPrimaryKey(Program.currentMember);
            else
                objData.AddNew();

            objData.MemberName = txtName.Text;
            objData.MemberFitness = int.Parse(cbFitness.SelectedValue.ToString());
            objData.MemberSpeed = int.Parse(cbSpeed.SelectedValue.ToString());
            objData.MemberTallness = int.Parse(cbTalness.SelectedValue.ToString());
            objData.MemberWeight = int.Parse(cbWeight.SelectedValue.ToString());
            objData.Save();
            bindMembersGrd();
            clearFields();
        }
        private void clearFields()
        {
            txtSearch.Text = "";
            txtName.Text = "";
            cbFitness.SelectedIndex = 0;
            cbSpeed.SelectedIndex = 0;
            cbTalness.SelectedIndex = 0;
            cbWeight.SelectedIndex = 0;
            Program.currentMember = 0;
            btnUpdate.Text = "Add";
        }
        private void MembersGrd_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            var senderGrid = (DataGridView)sender;
            if (senderGrid.Columns[e.ColumnIndex] is DataGridViewButtonColumn && e.RowIndex >= 0)
            {
                if (senderGrid.Columns[e.ColumnIndex].HeaderText == "Edit")
                {
                    Program.currentMember = int.Parse(senderGrid["ID",e.RowIndex].Value.ToString());
                    txtName.Text = senderGrid["MemberName", e.RowIndex].Value.ToString();
                    cbFitness.Text = senderGrid["Fitness", e.RowIndex].Value.ToString();
                    cbSpeed.Text = senderGrid["Speed", e.RowIndex].Value.ToString();
                    cbTalness.Text = senderGrid["Tallness", e.RowIndex].Value.ToString();
                    cbWeight.Text = senderGrid["Weight", e.RowIndex].Value.ToString();
                    btnUpdate.Text = "Update";
                }
                else if (senderGrid.Columns[e.ColumnIndex].HeaderText == "Delete")
                {
                    DialogResult res = MessageBox.Show("Are you sure you want to delete this member ?","Confirm",MessageBoxButtons.YesNo,MessageBoxIcon.Question);
                    if (res == DialogResult.Yes)
                    {
                        string MemberID = senderGrid["ID", e.RowIndex].Value.ToString();
                        BLL.SportClubMembers objDataMember = new BLL.SportClubMembers();
                        objDataMember.LoadByPrimaryKey(int.Parse(MemberID));
                        objDataMember.MarkAsDeleted();
                        objDataMember.Save();

                        bindMembersGrd();
                    }
                }
                else if (senderGrid.Columns[e.ColumnIndex].HeaderText == "Recommendations")
                {
                    string propFitness = senderGrid["Fitness", e.RowIndex].Value.ToString();
                    string propSpeed = senderGrid["Speed", e.RowIndex].Value.ToString();
                    string propTallness = senderGrid["Tallness", e.RowIndex].Value.ToString();
                    string propWeight = senderGrid["Weight", e.RowIndex].Value.ToString();

                    List<string> recommendedGames = getRecommendedGames(propFitness, propSpeed, propTallness, propWeight);
                    if (recommendedGames.Count== 0)
                    {
                        MessageBox.Show("No Recommended Games", "Games", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    }
                    else
                    {
                        string GamesMessage="Recommended Games : \n";
                        foreach (string item in recommendedGames)
                        {
                            GamesMessage += item + "\n";
                        }
                        MessageBox.Show(GamesMessage,"Games",MessageBoxButtons.OK,MessageBoxIcon.Information);
                    }
                }
            }
        }
        private void btnRules_Click(object sender, EventArgs e)
        {
            RulesForm rf = new RulesForm();
            rf.ShowDialog();
            rf.FormClosing += Rf_FormClosing;
        }
        private void Rf_FormClosing(object sender, FormClosingEventArgs e)
        {
            this.Close();
        }

        protected List<string> getRecommendedGames(string propFitness , string propSpeed , string propTallness , string propWeight)
        {
            List<string> RecommendedGames = new List<string>();

            List<string> CurrentMember = new List<string>();
            CurrentMember.Add(propFitness.ToLower());
            CurrentMember.Add(propSpeed.ToLower());
            CurrentMember.Add(propTallness.ToLower());
            CurrentMember.Add(propWeight.ToLower());

            XDocument xmlFile = XDocument.Load("E:\\R.xml");
            foreach (var Rule in xmlFile.Descendants("Rule"))
            {
                string gameName = Rule.Attribute("GameName").Value.ToString();
                List<string> gameAttributes = new List<string>();

                foreach (var Tuple in Rule.Descendants("tuble"))
                {
                    gameAttributes.Add(Tuple.Attribute("Value").Value.ToString().ToLower());
                }
                if (gameAttributes[0] == CurrentMember[0] && gameAttributes[1] == CurrentMember[1] && gameAttributes[2] == CurrentMember[2] && gameAttributes[3] == CurrentMember[3])
                    RecommendedGames.Add(gameName);
            }
            return RecommendedGames;
        }
    }
}
