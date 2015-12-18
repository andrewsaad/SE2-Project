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

namespace WindowsFormsApplication2
{
    public partial class RulesForm : Form
    {
        public class ComboBoxItem
        {
            public string Text { get; set; }
            public string Value { get; set; }

            public ComboBoxItem(string text,string value)
            {
                Text = text;
                Value = value;
            }
        }
        public RulesForm()
        {
            InitializeComponent();

            try
            {
                XmlDocument Checkrule = new XmlDocument();
                Checkrule.Load("E:\\R.xml");
                panel2.Enabled = true;

                XDocument doc = XDocument.Load("E:\\R.xml");
                var Rules = doc.Descendants("Rule");

                foreach (var rule in Rules)
                {
                    string GameName = rule.Attribute("GameName").Value.ToString();
                    cbRules.Items.Add(GameName);
                }

                cbCPT.SelectedIndex = 0;
                cbProperty.SelectedIndex = 0;
                cbRules.SelectedIndex = 0;
                cbValue.SelectedIndex = 0;
            }
            catch (Exception)
            {
                panel2.Enabled = false;
            }

        }
        private void button1_Click(object sender, EventArgs e)
        {
            try 
            {
                XmlDocument Checkrule = new XmlDocument();
                Checkrule.Load("E:\\R.xml");
                MessageBox.Show("File already exists !");
            }
            catch (Exception) 
            {
                XDocument Rule = new XDocument(
                new XDeclaration("1.0", "utf-8", "yes"),
                new XComment("SportClub Project"),
                new XElement("Root",
                new XElement("inference", new XAttribute("Name", "Differentiat")),
                new XElement("Cluster", new XAttribute("Name", "Confirmation"))));
                Rule.Save(@"E:\\R.xml");
                panel2.Enabled = true;
            }
        }
        private void button2_Click(object sender, EventArgs e)
        {
            XmlDocument rule = new XmlDocument();
            rule.Load("E:\\R.xml");
            string xmlLocationChecker = string.Format("//Rule[@GameName='{0}']/tuble[@Prop='{1}']" ,cbRules.SelectedItem.ToString() , cbProperty.SelectedItem.ToString());
            XmlNode tubleChecker = rule.SelectSingleNode(xmlLocationChecker);
            if (tubleChecker!=null)
            {
                DialogResult dr = MessageBox.Show("Tuble already exists !\nDo you want to replace it ?", "Warning", MessageBoxButtons.YesNo, MessageBoxIcon.Warning);
                //MessageBox.Show("Tuble already exists !", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                switch (dr)
                {
                    case DialogResult.None:
                        break;
                    case DialogResult.OK:
                        break;
                    case DialogResult.Cancel:
                        break;
                    case DialogResult.Abort:
                        break;
                    case DialogResult.Retry:
                        break;
                    case DialogResult.Ignore:
                        break;
                    case DialogResult.Yes:
                        XmlAttribute attrib = tubleChecker.OwnerDocument.CreateAttribute("Value");
                        attrib.Value = cbValue.SelectedItem.ToString();
                        tubleChecker.Attributes.Append(attrib);
                        rule.Save(@"E:\\R.xml");

                        MessageBox.Show("Tuble Updated Successfully", "Done", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        break;
                    case DialogResult.No:
                        break;
                    default:
                        break;
                }
            }
            else
            {
                string xmlLocation = string.Format("//Rule[@GameName='{0}']", cbRules.SelectedItem.ToString());
                XmlNode currRule = rule.SelectSingleNode(xmlLocation);
                XmlElement objdata = rule.CreateElement("tuble");
                objdata.SetAttribute("Cpt", cbCPT.SelectedItem.ToString());
                objdata.SetAttribute("Prop", cbProperty.SelectedItem.ToString());
                objdata.SetAttribute("Value", cbValue.SelectedItem.ToString());
                currRule.AppendChild(objdata);
                rule.Save(@"E:\\R.xml");

                MessageBox.Show("Tuble Added Successfully", "Done", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }
        private void button3_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(textBox1.Text) && !string.IsNullOrWhiteSpace(textBox2.Text))
            {
                string gameName = textBox2.Text;
                string ruleNumber = textBox1.Text;

                XDocument doc = XDocument.Load("E:\\R.xml");
                var Rules = doc.Descendants("Rule");
                List<string> gameNamesList = new List<string>();
                List<string> ruleNumberList = new List<string>();

                foreach (var rule in Rules)
                {
                    string GameName = rule.Attribute("GameName").Value.ToString().ToLower();
                    gameNamesList.Add(GameName);

                    string RuleNumber = rule.Attribute("RuleNumber").Value.ToString().ToLower();
                    ruleNumberList.Add(RuleNumber);
                }

                if (!gameNamesList.Contains(gameName.ToLower()) && !ruleNumberList.Contains(ruleNumber.ToLower()))
                {
                    XmlDocument rule1 = new XmlDocument();
                    rule1.Load("E:\\R.xml");
                    XmlNode root = rule1.SelectSingleNode("//Cluster");
                    XmlElement elem = rule1.CreateElement("Rule");
                    elem.SetAttribute("RuleNumber", textBox1.Text);
                    elem.SetAttribute("GameName", textBox2.Text.ToString());
                    XmlNode root1 = elem;
                    root.AppendChild(elem);
                    rule1.Save(@"E:\\R.xml");
                    cbRules.Items.Add(textBox2.Text);
                    textBox1.Text = "";
                    textBox2.Text = "";
                    MessageBox.Show("Rule created successfully", "Done", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                else
                {
                    MessageBox.Show("Rule Number or Game Name Already Exists", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
            else
            {
                MessageBox.Show("Please fill the required fields first !", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }
        }
        private void button5_Click(object sender, EventArgs e)
        {

        }
        private void btnBack_Click(object sender, EventArgs e)
        {
            this.Hide();
        }
    }
}
