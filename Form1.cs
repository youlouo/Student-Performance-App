using System.Drawing;
using System.Linq;
using System.Windows.Forms;

namespace Student_Performance_App
{
    public partial class Form1 : Form
    {
        private bool dragging = false;
        private Point dragCursorPoint;
        private Point dragFormPoint;
        public Form1()
        {
            InitializeComponent();
            this.FormBorderStyle = FormBorderStyle.None;

            this.MouseDown += Form1_MouseDown;
            this.MouseMove += Form1_MouseMove;
            this.MouseUp += Form1_MouseUp;
        }
        //Обновляем доступ к кнопке при вводе текста
        private void Text_Change(object sender, System.EventArgs e)
        {
            Check_Fields();
        }
        //Проверка на пустоту ввода данных
        private void Check_Fields()
        {
            bool usernameValid = !string.IsNullOrWhiteSpace(textBox1.Text);
            bool passwordValid = !string.IsNullOrWhiteSpace(textBox2.Text);
            button1.Enabled = usernameValid && passwordValid;
        }
        //Обработка переноса формы
        private void Form1_MouseDown(object sender, MouseEventArgs e)
        {
            dragging = true;
            dragCursorPoint = Cursor.Position;
            dragFormPoint = this.Location;
        }

        private void Form1_MouseMove(object sender, MouseEventArgs e)
        {
            if (dragging)
            {
                Point dif = Point.Subtract(Cursor.Position, new Size(dragCursorPoint));
                this.Location = Point.Add(dragFormPoint, new Size(dif));
            }
        }

        private void Form1_MouseUp(object sender, MouseEventArgs e)
        {
            dragging = false;
        }
        private void exit_button_Click(object sender, System.EventArgs e)
        {
            this.Close();
        }


        //Свернуть приложение
        private void Button_click_minimaized(object sender, System.EventArgs e)
        {
            this.WindowState = FormWindowState.Minimized;
        }
        //Закрыть приложение
        private void Is_checked(object sender, System.EventArgs e)
        {
            if (this.checkBox1.Checked == true) this.textBox2.PasswordChar = '\0';
            else this.textBox2.PasswordChar = '●';
        }
        //Обработка входа
        private void Log_in_click(object sender, System.EventArgs e)
        {
            string username = this.textBox1.Text.Trim();
            string password = this.textBox2.Text.Trim();
            string Role = Authenticate_User(username, password);
            if (Role != null)
            {
                this.Hide();
                MainForm mainForm = new MainForm(Role);
                mainForm.FormClosed += (s, args) => this.Close();
                mainForm.Show();
            }
            else
            {
                MessageBox.Show("Неверное имя пользователя или пароль!", "Ошибка входа", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
        //Обрабатка логина и пароля
        private string Authenticate_User(string username, string password)
        {
            if (username == "admin" && password == "admin") return "admin";
            if (username == "decan" && password == "decan") return "decan";
            if (username == "teacher" && password == "teacher") return "teacher";
            if (username == "student" && password == "student") return "student";
            else return null;
        }
    }
}
