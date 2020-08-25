import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.InputEvent;
import java.awt.event.ItemListener;
import java.awt.event.ItemEvent;
import java.awt.event.MouseListener;
import java.awt.event.MouseEvent;
import java.awt.Component;
import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.KeyStroke;
import javax.swing.JPopupMenu;	//多分いらんやつあるけど許して。

public class Menu implements MouseListener{
	JFrame frame;
	JPopupMenu popup;
	public Menu(PApplet app){
		System.setProperty("apple.laf.useScreenMenuBar", "true");	//アップル系のOSで使うやつだと思う。
		frame = (JFrame) ((processing.awt.PSurfaceAWT.SmoothCanvas)app.getSurface().getNative()).getFrame();
		JMenuBar menu_bar = new JMenuBar();
		frame.setJMenuBar(menu_bar);

		JMenu import_menu = new JMenu("インポート(I)");
		JMenu edit_menu = new JMenu("編集(E)");

		menu_bar.add(import_menu);
		menu_bar.add(edit_menu);

		import_menu.setMnemonic(KeyEvent.VK_I); //ショートカットキーを設定この場合だとalt+Iになる。
		edit_menu.setMnemonic(KeyEvent.VK_E);

		JMenuItem new_file = new JMenuItem("Import file");
		JMenuItem new_folder = new JMenuItem("Import folder");
		JMenuItem action_exit = new JMenuItem("Exit");

		import_menu.add(new_file);
		import_menu.add(new_folder);
		import_menu.addSeparator();	//線を書く
		import_menu.add(action_exit);

		// JMenuItem copy = new JMenuItem("コピー");

		// edit_menu.add(copy);

		action_exit.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_Q, InputEvent.CTRL_DOWN_MASK));	//ショートカットキーを設定この場合だとctrl+q

		frame.setVisible(true);	//多分おまじない
		popup = new JPopupMenu();
		JMenuItem import_item = new JMenuItem("import");
		JMenuItem import_item2 = new JMenuItem("import folder");
		JMenuItem trunr90 = new JMenuItem("右に90度回転");
		JMenuItem trun180 = new JMenuItem("180度回転");
		JMenuItem trunl90 = new JMenuItem("左に90度回転");
		JMenuItem trun20 = new JMenuItem("0度に回転");
		JMenuItem delete = new JMenuItem("削除");
		JMenuItem copy = new JMenuItem("コピー");
		JMenuItem paste = new JMenuItem("ペースト");

		// delete.setMnemonic(KeyEvent.VK_E);
		delete.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_DELETE,0));
		copy.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_C, InputEvent.CTRL_DOWN_MASK));
		paste.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_V, InputEvent.CTRL_DOWN_MASK));
		popup.add(copy);
		popup.add(paste);
		popup.add(delete);
		popup.addSeparator();
		popup.add(trunr90);
		popup.add(trun180);
		popup.add(trunl90);
		popup.add(trun20);
		import_item.addActionListener(new ActionListener() { //import_itemがクリックされたときにこいつを呼び出す。以下同
			public void actionPerformed(ActionEvent arg0) {
			}});

		trunr90.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				println(selectId);
				setDeg=1;
				if (setDeg>=4){
					setDeg=0;
				}
			}});
		trun180.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				setDeg=2;
				if(setDeg>=4){
					if(setDeg==4){
					setDeg=0;
					}else if(setDeg>=5){
						setDeg=1;
					}
				}
			}});
		trunl90.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				setDeg=3;
				if(setDeg<0){
					setDeg=3;
				}
			}});
		trun20.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				setDeg=0;
			}});

			action_exit.addActionListener(new ActionListener() {
				public void actionPerformed(ActionEvent arg0) {
					exit();
			}});
			delete.addActionListener(new ActionListener() {
				public void actionPerformed(ActionEvent arg0) {
						removeFlg=true;
			}});
			copy.addActionListener(new ActionListener() {
				public void actionPerformed(ActionEvent arg0) {
					copyFlg=true;
			}});
			paste.addActionListener(new ActionListener() {
				public void actionPerformed(ActionEvent arg0) {
					pasteFlg=true;
			}});
	}

	private void showPopup(MouseEvent e){
		if (e.isPopupTrigger()) {
			popup.show(e.getComponent(), e.getX(), e.getY()); //マウスの座標にメニューを表示
		}
	}

	@Override
	public void mouseClicked(MouseEvent e) {} //これがないとエラーが出たはず
	@Override
	public void mouseEntered(MouseEvent e) {		}
	@Override
	public void mouseExited(MouseEvent e) {}

	@Override
	public void mousePressed(MouseEvent e) {	//クリックされたらshowPopupを呼び出す。下も同じ
		showPopup(e);
	}

	@Override
	public void mouseReleased(MouseEvent e) {
		showPopup(e);
	}
	public void mouseWheelMoved(MouseWheelEvent e){
	}
}
