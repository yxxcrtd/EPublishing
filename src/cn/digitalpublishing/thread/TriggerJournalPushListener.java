package cn.digitalpublishing.thread;

import org.springframework.beans.factory.annotation.Autowired;

import cn.digitalpublishing.redis.dao.BookDao;

/**
 * 二级页面-中文电子期刊页-热读资源
 * 
 * @author liangkeqiang
 *
 */
public class TriggerJournalPushListener {
	@Autowired
	private BookDao bookDao;

	public void writeRedis() {
		Thread thread = new TriggerJournalPush(bookDao);
		thread.start();
	}
}
