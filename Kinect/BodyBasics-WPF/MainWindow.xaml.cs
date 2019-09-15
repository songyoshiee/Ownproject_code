//------------------------------------------------------------------------------
// <copyright file="MainWindow.xaml.cs" company="Microsoft">
//     Copyright (c) Microsoft Corporation.  All rights reserved.
// </copyright>
//------------------------------------------------------------------------------

// 내부에 데이터 저장
// 데이터 서버로 연결
// 리스트를 받아서 데이터 찍기
// http 클라이언트 이용해서 서버로 넘기기

namespace Microsoft.Samples.Kinect.BodyBasics
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.Diagnostics;
    using System.Globalization;
    using System.IO;
    using System.Windows;
    using System.Windows.Media;
    using System.Windows.Media.Imaging;
    using Microsoft.Kinect;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;
    using System.Data.SqlClient;
    using System.Data.Sql;
    using System.Data;
    using MySql.Data;
    using MySql.Data.MySqlClient;
    using System.Net;

    /// <summary>
    /// Interaction logic for MainWindow
    /// </summary>
    /// 

    public partial class MainWindow : Window, INotifyPropertyChanged
    {
        /// <summary>
        /// Radius of drawn hand circles
        /// </summary>
        private const double HandSize = 30;

        /// <summary>
        /// Thickness of drawn joint lines
        /// </summary>
        private const double JointThickness = 3;

        /// <summary>
        /// Thickness of clip edge rectangles
        /// </summary>
        private const double ClipBoundsThickness = 10;

        /// <summary>
        /// Constant for clamping Z values of camera space points from being negative
        /// </summary>
        private const float InferredZPositionClamp = 0.1f;

        /// <summary>
        /// Brush used for drawing hands that are currently tracked as closed
        /// </summary>
        private readonly Brush handClosedBrush = new SolidColorBrush(Color.FromArgb(128, 255, 0, 0));

        /// <summary>
        /// Brush used for drawing hands that are currently tracked as opened
        /// </summary>
        private readonly Brush handOpenBrush = new SolidColorBrush(Color.FromArgb(128, 0, 255, 0));

        /// <summary>
        /// Brush used for drawing hands that are currently tracked as in lasso (pointer) position
        /// </summary>
        private readonly Brush handLassoBrush = new SolidColorBrush(Color.FromArgb(128, 0, 0, 255));

        /// <summary>
        /// Brush used for drawing joints that are currently tracked
        /// </summary>
        private readonly Brush trackedJointBrush = new SolidColorBrush(Color.FromArgb(255, 68, 192, 68));

        /// <summary>
        /// Brush used for drawing joints that are currently inferred
        /// </summary>        
        private readonly Brush inferredJointBrush = Brushes.Yellow;

        /// <summary>
        /// Pen used for drawing bones that are currently inferred
        /// </summary>        
        private readonly Pen inferredBonePen = new Pen(Brushes.Gray, 1);

        /// <summary>
        /// Drawing group for body rendering output
        /// </summary>
        private DrawingGroup drawingGroup;

        /// <summary>
        /// Drawing image that we will display
        /// </summary>
        private DrawingImage imageSource;

        /// <summary>
        /// Active Kinect sensor
        /// </summary>
        private KinectSensor kinectSensor = null;

        /// <summary>
        /// Coordinate mapper to map one type of point to another
        /// </summary>
        private CoordinateMapper coordinateMapper = null;

        /// <summary>
        /// Reader for body frames
        /// </summary>
        private BodyFrameReader bodyFrameReader = null;

        /// <summary>
        /// Array for the bodies
        /// </summary>
        private Body[] bodies = null;

        /// <summary>
        /// definition of bones
        /// </summary>
        private List<Tuple<JointType, JointType>> bones;

        /// <summary>
        /// Width of display (depth space)
        /// </summary>
        private int displayWidth;

        /// <summary>
        /// Height of display (depth space)
        /// </summary>
        private int displayHeight;

        /// <summary>
        /// List of colors for each body tracked
        /// </summary>
        private List<Pen> bodyColors;

        /// <summary>
        /// Current status text to display
        /// </summary>
        private string statusText = null;

        /// <summary>
        /// Initializes a new instance of the MainWindow class.
        /// </summary>
        /// 

            // 케이스 명 (Directory Name)
        private static string caseNm = @"test";

            // 추출(수집) 개수
        int cnt = 100;

            // Directory Path
        private static string path = @"C:\Users\pc154\OneDrive\바탕 화면\project_data\" + caseNm + @"\";



        private static string filePath = path + @"0.Total.csv";
        
        StreamWriter sw;

        

        // 실헹
        public MainWindow()
        {


            // one sensor is currently supported
            this.kinectSensor = KinectSensor.GetDefault();

            // get the coordinate mapper
            this.coordinateMapper = this.kinectSensor.CoordinateMapper;

            // get the depth (display) extents
            FrameDescription frameDescription = this.kinectSensor.DepthFrameSource.FrameDescription;

            // get size of joint space
            this.displayWidth = frameDescription.Width;
            this.displayHeight = frameDescription.Height;

            // open the reader for the body frames
            this.bodyFrameReader = this.kinectSensor.BodyFrameSource.OpenReader();

            // a bone defined as a line between two joints
            this.bones = new List<Tuple<JointType, JointType>>();

            // Torso
            this.bones.Add(new Tuple<JointType, JointType>(JointType.Head, JointType.Neck));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.Neck, JointType.SpineShoulder));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.SpineShoulder, JointType.SpineMid));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.SpineMid, JointType.SpineBase));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.SpineShoulder, JointType.ShoulderRight));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.SpineShoulder, JointType.ShoulderLeft));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.SpineBase, JointType.HipRight));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.SpineBase, JointType.HipLeft));

            // Right Arm
            this.bones.Add(new Tuple<JointType, JointType>(JointType.ShoulderRight, JointType.ElbowRight));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.ElbowRight, JointType.WristRight));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.WristRight, JointType.HandRight));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.HandRight, JointType.HandTipRight));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.WristRight, JointType.ThumbRight));

            // Left Arm
            this.bones.Add(new Tuple<JointType, JointType>(JointType.ShoulderLeft, JointType.ElbowLeft));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.ElbowLeft, JointType.WristLeft));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.WristLeft, JointType.HandLeft));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.HandLeft, JointType.HandTipLeft));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.WristLeft, JointType.ThumbLeft));

            // Right Leg
            this.bones.Add(new Tuple<JointType, JointType>(JointType.HipRight, JointType.KneeRight));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.KneeRight, JointType.AnkleRight));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.AnkleRight, JointType.FootRight));

            // Left Leg
            this.bones.Add(new Tuple<JointType, JointType>(JointType.HipLeft, JointType.KneeLeft));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.KneeLeft, JointType.AnkleLeft));
            this.bones.Add(new Tuple<JointType, JointType>(JointType.AnkleLeft, JointType.FootLeft));

            // populate body colors, one for each BodyIndex
            this.bodyColors = new List<Pen>();

            this.bodyColors.Add(new Pen(Brushes.Red, 6));
            this.bodyColors.Add(new Pen(Brushes.Orange, 6));
            this.bodyColors.Add(new Pen(Brushes.Green, 6));
            this.bodyColors.Add(new Pen(Brushes.Blue, 6));
            this.bodyColors.Add(new Pen(Brushes.Indigo, 6));
            this.bodyColors.Add(new Pen(Brushes.Violet, 6));

            // set IsAvailableChanged event notifier
            this.kinectSensor.IsAvailableChanged += this.Sensor_IsAvailableChanged;

            // open the sensor
            this.kinectSensor.Open();

            // set the status text
            this.StatusText = this.kinectSensor.IsAvailable ? Properties.Resources.RunningStatusText
                                                            : Properties.Resources.NoSensorStatusText;

            // Create the drawing group we'll use for drawing
            this.drawingGroup = new DrawingGroup();

            // Create an image source that we can use in our image control
            this.imageSource = new DrawingImage(this.drawingGroup);

            // use the window object as the view model in this simple example
            this.DataContext = this;

            // initialize the components (controls) of the window
            this.InitializeComponent();


        }

        /// <summary>
        /// INotifyPropertyChangedPropertyChanged event to allow window controls to bind to changeable data
        /// </summary>
        public event PropertyChangedEventHandler PropertyChanged;

        /// <summary>
        /// Gets the bitmap to display
        /// </summary>
        public ImageSource ImageSource
        {
            get
            {
                return this.imageSource;
            }
        }

        /// <summary>
        /// Gets or sets the current status text to display
        /// </summary>
        public string StatusText
        {
            get
            {
                return this.statusText;
            }

            set
            {
                if (this.statusText != value)
                {
                    this.statusText = value;

                    // notify any bound elements that the text has changed
                    if (this.PropertyChanged != null)
                    {
                        this.PropertyChanged(this, new PropertyChangedEventArgs("StatusText"));
                    }
                }
            }
        }

        /// <summary>
        /// Execute start up tasks
        /// </summary>
        /// <param name="sender">object sending the event</param>
        /// <param name="e">event arguments</param>
        private void MainWindow_Loaded(object sender, RoutedEventArgs e)
        {
            if (this.bodyFrameReader != null)
            {
                this.bodyFrameReader.FrameArrived += this.Reader_FrameArrived;

                if (Directory.Exists(path))
                {
                    DirectoryInfo di = new DirectoryInfo(path);
                    foreach (FileInfo file in di.EnumerateFiles())
                    {
                        file.Delete();
                    }
                } else
                {
                    Directory.CreateDirectory(path);
                }

                //fs = File.Create(filePath);
                sw = new StreamWriter(filePath);
            }
        }

        /// <summary>
        /// Execute shutdown tasks
        /// </summary>
        /// <param name="sender">object sending the event</param>
        /// <param name="e">event arguments</param>
        private void MainWindow_Closing(object sender, CancelEventArgs e)
        {
            
            if (this.bodyFrameReader != null)
            {
                // BodyFrameReader is IDisposable
                this.bodyFrameReader.Dispose();
                this.bodyFrameReader = null;

                
            }

            if (this.kinectSensor != null)
            {
                this.kinectSensor.Close();
                this.kinectSensor = null;
            }

            sw.Flush();
            sw.Close();
            // Main File 쓰기 완료

            /*****************************
             * JointType 별로 File 분할
             * ***************************/

            StreamReader sr = new StreamReader(filePath);
            
            StreamWriter SpineBase = new StreamWriter(path + "1.SpineBase.csv");
            StreamWriter SpineMid = new StreamWriter(path + "2.SpineMid.csv");
            StreamWriter Neck = new StreamWriter(path + "3.Neck.csv");
            StreamWriter Head = new StreamWriter(path + "4.Head.csv");
            StreamWriter ShoulderLeft = new StreamWriter(path + "5.ShoulderLeft.csv");
            StreamWriter ElbowLeft = new StreamWriter(path + "6.ElbowLeft.csv");
            StreamWriter WristLeft = new StreamWriter(path + "7.WristLeft.csv");
            StreamWriter HandLeft = new StreamWriter(path + "8.HandLeft.csv");
            StreamWriter ShoulderRight = new StreamWriter(path + "9.ShoulderRight.csv");
            StreamWriter ElbowRight = new StreamWriter(path + "10.ElbowRight.csv");
            StreamWriter WristRight = new StreamWriter(path + "11.WristRight.csv");
            StreamWriter HandRight = new StreamWriter(path + "12.HandRight.csv");
            StreamWriter HipLeft = new StreamWriter(path + "13.HipLeft.csv");
            StreamWriter KneeLeft = new StreamWriter(path + "14.KneeLeft.csv");
            StreamWriter AnkleLeft = new StreamWriter(path + "15.AnkleLeft.csv");
            StreamWriter FootLeft = new StreamWriter(path + "16.FootLeft.csv");
            StreamWriter HipRight = new StreamWriter(path + "17.HipRight.csv");
            StreamWriter KneeRight = new StreamWriter(path + "18.KneeRight.csv");
            StreamWriter AnkleRight = new StreamWriter(path + "19.AnkleRight.csv");
            StreamWriter FootRight = new StreamWriter(path + "20.FootRight.csv");
            StreamWriter SpineShoulder = new StreamWriter(path + "21.SpineShoulder.csv");
            StreamWriter HandTipLeft = new StreamWriter(path + "22.HandTipLeft.csv");
            StreamWriter ThumbLeft = new StreamWriter(path + "23.ThumbLeft.csv");
            StreamWriter HandTipRight = new StreamWriter(path + "24.HandTipRight.csv");
            StreamWriter ThumbRight = new StreamWriter(path + "25.ThumbRight.csv");
            
            string line = sr.ReadLine();

            while(line != null)
            {
                string[] spLine = line.Split(',');

                SpineBase.WriteLine(spLine[3 * Convert.ToInt32(JointType.SpineBase)] + "," + spLine[3 * Convert.ToInt32(JointType.SpineBase) + 1] + "," + spLine[3 * Convert.ToInt32(JointType.SpineBase) + 2]);
                SpineMid.WriteLine(spLine[3 * Convert.ToInt32(JointType.SpineMid)] + "," + spLine[3 * Convert.ToInt32(JointType.SpineMid) + 1] + "," + spLine[3 * Convert.ToInt32(JointType.SpineMid) + 2]);
                Neck.WriteLine(spLine[3 * Convert.ToInt32(JointType.Neck)] + "," + spLine[3 * Convert.ToInt32(JointType.Neck) + 1] + "," + spLine[3 * Convert.ToInt32(JointType.Neck) + 2]);
                Head.WriteLine(spLine[3 * Convert.ToInt32(JointType.Head)] + "," + spLine[3 * Convert.ToInt32(JointType.Head) + 1] + "," + spLine[3 * Convert.ToInt32(JointType.Head) + 2]);
                ShoulderLeft.WriteLine(spLine[3 * Convert.ToInt32(JointType.ShoulderLeft)] + "," + spLine[3 * Convert.ToInt32(JointType.ShoulderLeft) + 1] + "," + spLine[3 * Convert.ToInt32(JointType.ShoulderLeft) + 2]);
                ElbowLeft.WriteLine(spLine[3 * Convert.ToInt32(JointType.ElbowLeft)] + "," + spLine[3 * Convert.ToInt32(JointType.ElbowLeft) + 1] + "," + spLine[3 * Convert.ToInt32(JointType.ElbowLeft) + 2]);
                WristLeft.WriteLine(spLine[3 * Convert.ToInt32(JointType.WristLeft)] + "," + spLine[3 * Convert.ToInt32(JointType.WristLeft) + 1] + "," + spLine[3 * Convert.ToInt32(JointType.WristLeft) + 2]);
                HandLeft.WriteLine(spLine[3 * Convert.ToInt32(JointType.HandLeft)] + "," + spLine[3 * Convert.ToInt32(JointType.HandLeft) + 1] + "," + spLine[3 * Convert.ToInt32(JointType.HandLeft) + 2]);
                ShoulderRight.WriteLine(spLine[3 * Convert.ToInt32(JointType.ShoulderRight)] + "," + spLine[3 * Convert.ToInt32(JointType.ShoulderRight) + 1] + "," + spLine[3 * Convert.ToInt32(JointType.ShoulderRight) + 2]);
                ElbowRight.WriteLine(spLine[3 * Convert.ToInt32(JointType.ElbowRight)] + "," + spLine[3 * Convert.ToInt32(JointType.ElbowRight) + 1] + "," + spLine[3 * Convert.ToInt32(JointType.ElbowRight) + 2]);
                WristRight.WriteLine(spLine[3 * Convert.ToInt32(JointType.WristRight)] + "," + spLine[3 * Convert.ToInt32(JointType.WristRight) + 1] + "," + spLine[3 * Convert.ToInt32(JointType.WristRight) + 2]);
                HandRight.WriteLine(spLine[3 * Convert.ToInt32(JointType.HandRight)] + "," + spLine[3 * Convert.ToInt32(JointType.HandRight) + 1] + "," + spLine[3 * Convert.ToInt32(JointType.HandRight) + 2]);
                HipLeft.WriteLine(spLine[3 * Convert.ToInt32(JointType.HipLeft)] + "," + spLine[3 * Convert.ToInt32(JointType.HipLeft) + 1] + "," + spLine[3 * Convert.ToInt32(JointType.HipLeft) + 2]);
                KneeLeft.WriteLine(spLine[3 * Convert.ToInt32(JointType.KneeLeft)] + "," + spLine[3 * Convert.ToInt32(JointType.KneeLeft) + 1] + "," + spLine[3 * Convert.ToInt32(JointType.KneeLeft) + 2]);
                AnkleLeft.WriteLine(spLine[3 * Convert.ToInt32(JointType.AnkleLeft)] + "," + spLine[3 * Convert.ToInt32(JointType.AnkleLeft) + 1] + "," + spLine[3 * Convert.ToInt32(JointType.AnkleLeft) + 2]);
                FootLeft.WriteLine(spLine[3 * Convert.ToInt32(JointType.FootLeft)] + "," + spLine[3 * Convert.ToInt32(JointType.FootLeft) + 1] + "," + spLine[3 * Convert.ToInt32(JointType.FootLeft) + 2]);
                HipRight.WriteLine(spLine[3 * Convert.ToInt32(JointType.HipRight)] + "," + spLine[3 * Convert.ToInt32(JointType.HipRight) + 1] + "," + spLine[3 * Convert.ToInt32(JointType.HipRight) + 2]);
                KneeRight.WriteLine(spLine[3 * Convert.ToInt32(JointType.KneeRight)] + "," + spLine[3 * Convert.ToInt32(JointType.KneeRight) + 1] + "," + spLine[3 * Convert.ToInt32(JointType.KneeRight) + 2]);
                AnkleRight.WriteLine(spLine[3 * Convert.ToInt32(JointType.AnkleRight)] + "," + spLine[3 * Convert.ToInt32(JointType.AnkleRight) + 1] + "," + spLine[3 * Convert.ToInt32(JointType.AnkleRight) + 2]);
                FootRight.WriteLine(spLine[3 * Convert.ToInt32(JointType.FootRight)] + "," + spLine[3 * Convert.ToInt32(JointType.FootRight) + 1] + "," + spLine[3 * Convert.ToInt32(JointType.FootRight) + 2]);
                SpineShoulder.WriteLine(spLine[3 * Convert.ToInt32(JointType.SpineShoulder)] + "," + spLine[3 * Convert.ToInt32(JointType.SpineShoulder) + 1] + "," + spLine[3 * Convert.ToInt32(JointType.SpineShoulder) + 2]);
                HandTipLeft.WriteLine(spLine[3 * Convert.ToInt32(JointType.HandTipLeft)] + "," + spLine[3 * Convert.ToInt32(JointType.HandTipLeft) + 1] + "," + spLine[3 * Convert.ToInt32(JointType.HandTipLeft) + 2]);
                ThumbLeft.WriteLine(spLine[3 * Convert.ToInt32(JointType.ThumbLeft)] + "," + spLine[3 * Convert.ToInt32(JointType.ThumbLeft) + 1] + "," + spLine[3 * Convert.ToInt32(JointType.ThumbLeft) + 2]);
                HandTipRight.WriteLine(spLine[3 * Convert.ToInt32(JointType.HandTipRight)] + "," + spLine[3 * Convert.ToInt32(JointType.HandTipRight) + 1] + "," + spLine[3 * Convert.ToInt32(JointType.HandTipRight) + 2]);
                ThumbRight.WriteLine(spLine[3 * Convert.ToInt32(JointType.ThumbRight)] + "," + spLine[3 * Convert.ToInt32(JointType.ThumbRight) + 1] + "," + spLine[3 * Convert.ToInt32(JointType.ThumbRight) + 2]);
                
                line = sr.ReadLine();
            }

            sr.Close();

            SpineBase.Flush();
            SpineMid.Flush();
            Neck.Flush();
            Head.Flush();
            ShoulderLeft.Flush();
            ElbowLeft.Flush();
            WristLeft.Flush();
            HandLeft.Flush();
            ShoulderRight.Flush();
            ElbowRight.Flush();
            WristRight.Flush();
            HandRight.Flush();
            HipLeft.Flush();
            KneeLeft.Flush();
            AnkleLeft.Flush();
            FootLeft.Flush();
            HipRight.Flush();
            KneeRight.Flush();
            AnkleRight.Flush();
            FootRight.Flush();
            SpineShoulder.Flush();
            HandTipLeft.Flush();
            ThumbLeft.Flush();
            HandTipRight.Flush();
            ThumbRight.Flush();

            SpineBase.Close();
            SpineMid.Close();
            Neck.Close();
            Head.Close();
            ShoulderLeft.Close();
            ElbowLeft.Close();
            WristLeft.Close();
            HandLeft.Close();
            ShoulderRight.Close();
            ElbowRight.Close();
            WristRight.Close();
            HandRight.Close();
            HipLeft.Close();
            KneeLeft.Close();
            AnkleLeft.Close();
            FootLeft.Close();
            HipRight.Close();
            KneeRight.Close();
            AnkleRight.Close();
            FootRight.Close();
            SpineShoulder.Close();
            HandTipLeft.Close();
            ThumbLeft.Close();
            HandTipRight.Close();
            ThumbRight.Close();
        }

        /// <summary>
        /// Handles the body frame data arriving from the sensor
        /// </summary>
        /// <param name="sender">object sending the event</param>
        /// <param name="e">event arguments</param>
        private void Reader_FrameArrived(object sender, BodyFrameArrivedEventArgs e)
        {
            bool dataReceived = false;
            Console.WriteLine("읽어오는중");

            using (BodyFrame bodyFrame = e.FrameReference.AcquireFrame())
            {
                if (bodyFrame != null)
                {
                    if (this.bodies == null)
                    {
                        this.bodies = new Body[bodyFrame.BodyCount];
                    }

                    // The first time GetAndRefreshBodyData is called, Kinect will allocate each Body in the array.
                    // As long as those body objects are not disposed and not set to null in the array,
                    // those body objects will be re-used.
                    bodyFrame.GetAndRefreshBodyData(this.bodies);

                    dataReceived = true;
                }
            }

            if (dataReceived)
            {
                Console.WriteLine("데이터 읽음" + this.bodies.Length);

                using (DrawingContext dc = this.drawingGroup.Open())
                {
                    // Draw a transparent background to set the render size
                    dc.DrawRectangle(Brushes.Black, null, new Rect(0.0, 0.0, this.displayWidth, this.displayHeight));

                    int penIndex = 0;
                    foreach (Body body in this.bodies)
                    {
                        Pen drawPen = this.bodyColors[penIndex++];

                        if (body.IsTracked)
                        {
                            Console.WriteLine("바디 트랙중");
                            this.DrawClippedEdges(body, dc);

                            IReadOnlyDictionary<JointType, Joint> joints = body.Joints;

                            // convert the joint points to depth (display) space
                            Dictionary<JointType, Point> jointPoints = new Dictionary<JointType, Point>();

                            foreach (JointType jointType in joints.Keys)
                            {
                                // sometimes the depth(Z) of an inferred joint may show as negative
                                // clamp down to 0.1f to prevent coordinatemapper from returning (-Infinity, -Infinity)
                                CameraSpacePoint position = joints[jointType].Position;
                                if (position.Z < 0)
                                {
                                    position.Z = InferredZPositionClamp;
                                }

                                // head 출력
                                Dictionary<string, string> head = new Dictionary<string, string>();
                                if (jointType == JointType.Head)
                                {
                                    head.Add("3", ("(" + position.X + ", " + position.Y + ", " + position.Z + ")"));
                                    Object value = head["3"];
                                    Console.Write(value + "  좌표(Head): 3" + "\n");

                                    if (cnt > 0)
                                    {
                                        sw.Write("," + position.X + "," + position.Y + "," + position.Z);
                                    }
                                }

                                // neck 출력
                                Dictionary<string, string> neck = new Dictionary<string, string>();
                                if (jointType == JointType.Neck)
                                {
                                    neck.Add("2", ("(" + position.X + ", " + position.Y + ", " + position.Z + ")"));
                                    Object value = neck["2"];
                                    Console.Write(value + "  좌표(Neck): 2" + "\n");

                                    if (cnt > 0)
                                    {
                                        sw.Write("," + position.X + "," + position.Y + "," + position.Z);
                                    }
                                }

                                // spineshoulder 출력
                                Dictionary<string, string> spineshoulder = new Dictionary<string, string>();
                                if (jointType == JointType.SpineShoulder)
                                {
                                    spineshoulder.Add("20", ("(" + position.X + ", " + position.Y + ", " + position.Z + ")"));
                                    Object value = spineshoulder["20"];
                                    Console.Write(value + "  좌표(SpineShoulder): 20" + "\n");

                                    if (cnt > 0)
                                    {
                                        sw.Write("," + position.X + "," + position.Y + "," + position.Z);
                                    }
                                }

                                // shoulderleft 출력
                                Dictionary<string, string> shoulderleft = new Dictionary<string, string>();
                                if (jointType == JointType.ShoulderLeft)
                                {
                                    shoulderleft.Add("4", ("(" + position.X + ", " + position.Y + ", " + position.Z + ")"));
                                    Object value = shoulderleft["4"];
                                    Console.Write(value + "  좌표(ShoulerLeft): 4" + "\n");

                                    if (cnt > 0)
                                    {
                                        sw.Write("," + position.X + "," + position.Y + "," + position.Z);
                                    }
                                }

                                // shoulderright 출력
                                Dictionary<string, string> shoulderright = new Dictionary<string, string>();
                                if (jointType == JointType.ShoulderRight)
                                {
                                    shoulderright.Add("8", ("(" + position.X + ", " + position.Y + ", " + position.Z + ")"));
                                    Object value = shoulderright["8"];
                                    Console.Write(value + "  좌표(ShoulderRight): 8" + "\n");

                                    if (cnt > 0)
                                    {
                                        sw.Write("," + position.X + "," + position.Y + "," + position.Z);
                                    }
                                }

                                // elbowleft 출력
                                Dictionary<string, string> elbowleft = new Dictionary<string, string>();
                                if (jointType == JointType.ElbowLeft)
                                {
                                    elbowleft.Add("5", ("(" + position.X + ", " + position.Y + ", " + position.Z + ")"));
                                    Object value = elbowleft["5"];
                                    Console.Write(value + "  좌표(ElbowLeft): 5" + "\n");

                                    if (cnt > 0)
                                    {
                                        sw.Write("," + position.X + "," + position.Y + "," + position.Z);
                                    }
                                }

                                // elbowright 출력
                                Dictionary<string, string> elbowright = new Dictionary<string, string>();
                                if (jointType == JointType.ElbowRight)
                                {
                                    elbowright.Add("9", ("(" + position.X + ", " + position.Y + ", " + position.Z + ")"));
                                    Object value = elbowright["9"];
                                    Console.Write(value + "  좌표(ElbowRignt): 9" + "\n");

                                    if (cnt > 0)
                                    {
                                        sw.Write("," + position.X + "," + position.Y + "," + position.Z);
                                    }
                                }

                                // wristleft 출력
                                Dictionary<string, string> wristleft = new Dictionary<string, string>();
                                if (jointType == JointType.WristLeft)
                                {
                                    wristleft.Add("6", ("(" + position.X + ", " + position.Y + ", " + position.Z + ")"));
                                    Object value = wristleft["6"];
                                    Console.Write(value + "  좌표(WristLeft): 6" + "\n");

                                    if (cnt > 0)
                                    {
                                        sw.Write("," + position.X + "," + position.Y + "," + position.Z);
                                    }
                                }

                                // wristright 출력
                                Dictionary<string, string> wristright = new Dictionary<string, string>();
                                if (jointType == JointType.WristRight)
                                {
                                    wristright.Add("10", ("(" + position.X + ", " + position.Y + ", " + position.Z + ")"));
                                    Object value = wristright["10"];
                                    Console.Write(value + "  좌표(WristRight): 10" + "\n");

                                    if (cnt > 0)
                                    {
                                        sw.Write("," + position.X + "," + position.Y + "," + position.Z);
                                    }
                                }

                                // thumbleft 출력
                                Dictionary<string, string> thumbleft = new Dictionary<string, string>();
                                if (jointType == JointType.ThumbLeft)
                                {
                                    thumbleft.Add("22", ("(" + position.X + ", " + position.Y + ", " + position.Z + ")"));
                                    Object value = thumbleft["22"];
                                    Console.Write(value + "  좌표(ThumbLeft): 22" + "\n");

                                    if (cnt > 0)
                                    {
                                        sw.Write("," + position.X + "," + position.Y + "," + position.Z);
                                    }
                                }

                                // thumbright 출력
                                Dictionary<string, string> thumbright = new Dictionary<string, string>();
                                if (jointType == JointType.ThumbRight)
                                {
                                    thumbright.Add("24", ("(" + position.X + ", " + position.Y + ", " + position.Z + ")"));
                                    Object value = thumbright["24"];
                                    Console.Write(value + "  좌표(ThumbRight): 24" + "\n");

                                    if (cnt > 0)
                                    {
                                        sw.WriteLine("," + position.X + "," + position.Y + "," + position.Z);
                                        cnt--;
                                    }
                                }

                                // handleft 출력
                                Dictionary<string, string> handleft = new Dictionary<string, string>();
                                if (jointType == JointType.HandLeft)
                                {
                                    handleft.Add("7", ("(" + position.X + ", " + position.Y + ", " + position.Z + ")"));
                                    Object value = handleft["7"];
                                    Console.Write(value + "  좌표(HandLeft): 7" + "\n");

                                    if (cnt > 0)
                                    {
                                        sw.Write("," + position.X + "," + position.Y + "," + position.Z);
                                    }
                                }

                                // handright 출력
                                Dictionary<string, string> handright = new Dictionary<string, string>();
                                if (jointType == JointType.HandRight)
                                {
                                    handright.Add("11", ("(" + position.X + ", " + position.Y + ", " + position.Z + ")"));
                                    Object value = handright["11"];
                                    Console.Write(value + "  좌표(HandRight): 11" + "\n");

                                    if (cnt > 0)
                                    {
                                        sw.Write("," + position.X + "," + position.Y + "," + position.Z);
                                    }
                                }

                                // handtipleft 출력
                                Dictionary<string, string> handtipleft = new Dictionary<string, string>();
                                if (jointType == JointType.HandTipLeft)
                                {
                                    handtipleft.Add("21", ("(" + position.X + ", " + position.Y + ", " + position.Z + ")"));
                                    Object value = handtipleft["21"];
                                    Console.Write(value + "  좌표(HandTipLeft): 21" + "\n");

                                    if (cnt > 0)
                                    {
                                        sw.Write("," + position.X + "," + position.Y + "," + position.Z);
                                    }
                                }

                                // handtipright 출력
                                Dictionary<string, string> handtipright = new Dictionary<string, string>();
                                if (jointType == JointType.HandTipRight)
                                {
                                    handtipright.Add("23", ("(" + position.X + ", " + position.Y + ", " + position.Z + ")"));
                                    Object value = handtipright["23"];
                                    Console.Write(value + "  좌표(HandTipRight): 23" + "\n");

                                    if (cnt > 0)
                                    {
                                        sw.Write("," + position.X + "," + position.Y + "," + position.Z);
                                    }
                                }

                                // spinemid 출력
                                Dictionary<string, string> spinemid = new Dictionary<string, string>();
                                if (jointType == JointType.SpineMid)
                                {
                                    spinemid.Add("1", ("(" + position.X + ", " + position.Y + ", " + position.Z + ")"));
                                    Object value = spinemid["1"];
                                    Console.Write(value + "  좌표(spinemid): 1" + "\n");

                                    if (cnt > 0)
                                    {
                                        sw.Write("," + position.X + "," + position.Y + "," + position.Z);
                                    }
                                }

                                // spinebase 출력
                                Dictionary<string, string> spinebase = new Dictionary<string, string>();
                                if (jointType == JointType.SpineBase)
                                {
                                    spinebase.Add("0", ("(" + position.X + ", " + position.Y + ", " + position.Z + ")"));
                                    Object value = spinebase["0"];
                                    Console.Write(value + " 좌표(spinebase): 0" + "\n");

                                    if (cnt > 0)
                                    {
                                        sw.Write(position.X + "," + position.Y + "," + position.Z);
                                    }
                                }

                                // hipleft 출력
                                Dictionary<string, string> hipleft = new Dictionary<string, string>();
                                if (jointType == JointType.HipLeft)
                                {
                                    hipleft.Add("12", ("(" + position.X + ", " + position.Y + ", " + position.Z + ")"));
                                    Object value = hipleft["12"];
                                    Console.Write(value + " 좌표(hipleft): 12" + "\n");

                                    if (cnt > 0)
                                    {
                                        sw.Write("," + position.X + "," + position.Y + "," + position.Z);
                                    }
                                }

                                // hipright 출력
                                Dictionary<string, string> hipright = new Dictionary<string, string>();
                                if (jointType == JointType.HipRight)
                                {
                                    hipright.Add("16", ("(" + position.X + ", " + position.Y + ", " + position.Z + ")"));
                                    Object value = hipright["16"];
                                    Console.Write(value + " 좌표(hipright): 16" + "\n");

                                    if (cnt > 0)
                                    {
                                        sw.Write("," + position.X + "," + position.Y + "," + position.Z);
                                    }
                                }

                                //kneeleft 출력
                                Dictionary<string, string> kneeleft = new Dictionary<string, string>();
                                if (jointType == JointType.KneeLeft)
                                {
                                    kneeleft.Add("13", ("(" + position.X + ", " + position.Y + ", " + position.Z + ")"));
                                    Object value = kneeleft["13"];
                                    Console.Write(value + " 좌표(kneeleft): 13" + "\n");

                                    if (cnt > 0)
                                    {
                                        sw.Write("," + position.X + "," + position.Y + "," + position.Z);
                                    }
                                }

                                // kneeright 출력
                                Dictionary<string, string> kneerignt = new Dictionary<string, string>();
                                if (jointType == JointType.KneeRight)
                                {
                                    kneerignt.Add("17", ("(" + position.X + ", " + position.Y + ", " + position.Z + ")"));
                                    Object value = kneerignt["17"];
                                    Console.Write(value + " 좌표(kneeright): 17" + "\n");

                                    if (cnt > 0)
                                    {
                                        sw.Write("," + position.X + "," + position.Y + "," + position.Z);
                                    }
                                }

                                // ankleleft 출력
                                Dictionary<string, string> ankleleft = new Dictionary<string, string>();
                                if (jointType == JointType.AnkleLeft)
                                {
                                    ankleleft.Add("14", ("(" + position.X + ", " + position.Y + ", " + position.Z + ")"));
                                    Object value = ankleleft["14"];
                                    Console.Write(value + " 좌표(ankleleft): 14" + "\n");

                                    if (cnt > 0)
                                    {
                                        sw.Write("," + position.X + "," + position.Y + "," + position.Z);
                                    }
                                }

                                // ankleright 출력
                                Dictionary<string, string> anklerignt = new Dictionary<string, string>();
                                if (jointType == JointType.AnkleRight)
                                {
                                    anklerignt.Add("18", ("(" + position.X + ", " + position.Y + ", " + position.Z + ")"));
                                    Object value = anklerignt["18"];
                                    Console.Write(value + " 좌표(ankleright): 18" + "\n");

                                    if (cnt > 0)
                                    {
                                        sw.Write("," + position.X + "," + position.Y + "," + position.Z);
                                    }
                                }

                                // footleft 출력
                                Dictionary<string, string> footleft = new Dictionary<string, string>();
                                if (jointType == JointType.FootLeft)
                                {
                                    footleft.Add("15", ("(" + position.X + ", " + position.Y + ", " + position.Z + ")"));
                                    Object value = footleft["15"];
                                    Console.Write(value + " 좌표(footleft): 15" + "\n");

                                    if (cnt > 0)
                                    {
                                        sw.Write("," + position.X + "," + position.Y + "," + position.Z);
                                    }
                                }

                                // footright 출력
                                Dictionary<string, string> footright = new Dictionary<string, string>();
                                if (jointType == JointType.FootRight)
                                {
                                    footright.Add("19", ("(" + position.X + ", " + position.Y + ", " + position.Z + ")"));
                                    Object value = footright["19"];
                                    Console.Write(value + " 좌표(footright): 19" + "\n");

                                    if (cnt > 0)
                                    {
                                        sw.Write("," + position.X + "," + position.Y + "," + position.Z);
                                    }
                                }


                                // Console.WriteLine(position.X + " " + position.Y + " " + position.Z + " " + jointType);

                                DepthSpacePoint depthSpacePoint = this.coordinateMapper.MapCameraPointToDepthSpace(position);
                                jointPoints[jointType] = new Point(depthSpacePoint.X, depthSpacePoint.Y);
                            }


                            this.DrawBody(joints, jointPoints, dc, drawPen);
                            this.DrawHand(body.HandLeftState, jointPoints[JointType.HandLeft], dc);
                            this.DrawHand(body.HandRightState, jointPoints[JointType.HandRight], dc);
                        }
                    }

                    // prevent drawing outside of our render area
                    this.drawingGroup.ClipGeometry = new RectangleGeometry(new Rect(0.0, 0.0, this.displayWidth, this.displayHeight));
                }
            }

        }

        /// <summary>
        /// Draws a body
        /// </summary>
        /// <param name="joints">joints to draw</param>
        /// <param name="jointPoints">translated positions of joints to draw</param>
        /// <param name="drawingContext">drawing context to draw to</param>
        /// <param name="drawingPen">specifies color to draw a specific body</param>
        private void DrawBody(IReadOnlyDictionary<JointType, Joint> joints, IDictionary<JointType, Point> jointPoints, DrawingContext drawingContext, Pen drawingPen)
        {
            // Draw the bones
            Console.WriteLine(" \n 바디 뼈대그리기");

            foreach (var bone in this.bones)
            {
                this.DrawBone(joints, jointPoints, bone.Item1, bone.Item2, drawingContext, drawingPen);
            }

            // Draw the joints
            foreach (JointType jointType in joints.Keys)
            {
                Brush drawBrush = null;

                TrackingState trackingState = joints[jointType].TrackingState;

                if (trackingState == TrackingState.Tracked)
                {
                    drawBrush = this.trackedJointBrush;
                }
                else if (trackingState == TrackingState.Inferred)
                {
                    drawBrush = this.inferredJointBrush;
                }

                if (drawBrush != null)
                {
                    drawingContext.DrawEllipse(drawBrush, null, jointPoints[jointType], JointThickness, JointThickness);
                }
            }
        }

        /// <summary>
        /// Draws one bone of a body (joint to joint)
        /// </summary>
        /// <param name="joints">joints to draw</param>
        /// <param name="jointPoints">translated positions of joints to draw</param>
        /// <param name="jointType0">first joint of bone to draw</param>
        /// <param name="jointType1">second joint of bone to draw</param>
        /// <param name="drawingContext">drawing context to draw to</param>
        /// /// <param name="drawingPen">specifies color to draw a specific bone</param>
        private void DrawBone(IReadOnlyDictionary<JointType, Joint> joints, IDictionary<JointType, Point> jointPoints, JointType jointType0, JointType jointType1, DrawingContext drawingContext, Pen drawingPen)
        {
            Joint joint0 = joints[jointType0];
            Joint joint1 = joints[jointType1];

            // If we can't find either of these joints, exit
            if (joint0.TrackingState == TrackingState.NotTracked ||
                joint1.TrackingState == TrackingState.NotTracked)
            {
                return;
            }

            // We assume all drawn bones are inferred unless BOTH joints are tracked
            Pen drawPen = this.inferredBonePen;
            if ((joint0.TrackingState == TrackingState.Tracked) && (joint1.TrackingState == TrackingState.Tracked))
            {
                drawPen = drawingPen;
            }

            drawingContext.DrawLine(drawPen, jointPoints[jointType0], jointPoints[jointType1]);
        }

        /// <summary>
        /// Draws a hand symbol if the hand is tracked: red circle = closed, green circle = opened; blue circle = lasso
        /// </summary>
        /// <param name="handState">state of the hand</param>
        /// <param name="handPosition">position of the hand</param>
        /// <param name="drawingContext">drawing context to draw to</param>
        private void DrawHand(HandState handState, Point handPosition, DrawingContext drawingContext)
        {
            switch (handState)
            {
                case HandState.Closed:
                    drawingContext.DrawEllipse(this.handClosedBrush, null, handPosition, HandSize, HandSize);
                    break;

                case HandState.Open:
                    drawingContext.DrawEllipse(this.handOpenBrush, null, handPosition, HandSize, HandSize);
                    break;

                case HandState.Lasso:
                    drawingContext.DrawEllipse(this.handLassoBrush, null, handPosition, HandSize, HandSize);
                    break;
            }
        }

        /// <summary>
        /// Draws indicators to show which edges are clipping body data
        /// </summary>
        /// <param name="body">body to draw clipping information for</param>
        /// <param name="drawingContext">drawing context to draw to</param>
        private void DrawClippedEdges(Body body, DrawingContext drawingContext)
        {
            FrameEdges clippedEdges = body.ClippedEdges;

            if (clippedEdges.HasFlag(FrameEdges.Bottom))
            {
                drawingContext.DrawRectangle(
                    Brushes.Red,
                    null,
                    new Rect(0, this.displayHeight - ClipBoundsThickness, this.displayWidth, ClipBoundsThickness));
            }

            if (clippedEdges.HasFlag(FrameEdges.Top))
            {
                drawingContext.DrawRectangle(
                    Brushes.Red,
                    null,
                    new Rect(0, 0, this.displayWidth, ClipBoundsThickness));
            }

            if (clippedEdges.HasFlag(FrameEdges.Left))
            {
                drawingContext.DrawRectangle(
                    Brushes.Red,
                    null,
                    new Rect(0, 0, ClipBoundsThickness, this.displayHeight));
            }

            if (clippedEdges.HasFlag(FrameEdges.Right))
            {
                drawingContext.DrawRectangle(
                    Brushes.Red,
                    null,
                    new Rect(this.displayWidth - ClipBoundsThickness, 0, ClipBoundsThickness, this.displayHeight));
            }
        }

        /// <summary>
        /// Handles the event which the sensor becomes unavailable (E.g. paused, closed, unplugged).
        /// </summary>
        /// <param name="sender">object sending the event</param>
        /// <param name="e">event arguments</param>
        private void Sensor_IsAvailableChanged(object sender, IsAvailableChangedEventArgs e)
        {
            // on failure, set the status text
            this.StatusText = this.kinectSensor.IsAvailable ? Properties.Resources.RunningStatusText
                                                            : Properties.Resources.SensorNotAvailableStatusText;
        }
    }
}