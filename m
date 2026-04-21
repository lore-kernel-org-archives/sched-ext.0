Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE7B2AF1D
	for <sched-ext@lists.linux.dev>; Tue, 21 Apr 2026 08:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776760855; cv=none; b=ds4JF9v4kJZ0WcHvHzxNgCOU2ORE4CdROzCj3JghUb77y2WxbEp3FmUFJCIw4aWI/5uurRnFGVxdJR8cbSdYjPrEDC46CGantyGA/ouy0X26276LIWT3WKKx/wVgtT7Jik7WTM79opWJfjq0jX7i8jOWoERyEzFklPd2p1cx+vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776760855; c=relaxed/simple;
	bh=sf6U2HZdc26s7AkIAEwD5g+mQSbOxhI5TTy+X7Hjly4=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=SDwWuKfQRU7muw5UQbGoib+Jsa+7sSFhHhW+voGpc2x/WTmtjWyvZeitJvZ88F6u5Bz522PLzK4q5QVxHR2srzLmZOSc4wRXo5xwcyHF9upbjfXWyCL0s1jrHb2DBUgqX4Yehbg9dfkoxRW2DooYQnnB2WXmbFYMtLlNZ0R2AA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=APxsJ7aR; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="APxsJ7aR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=MIME-Version:Content-Type:Subject:From:To:Date:
	Message-Id; bh=JlGs6HJ34E9nHSr7VKtFT+z9BrAydBq+x3dr99gXYT4=; b=A
	PxsJ7aRk0dYHh7UfXV5pJAv97AE2/klsNBiejxznhBGr6joGkVhd40nVLYVHPIfP
	pT/o9f9dVQH0yVGUYkqA4npsKfiPbiGvxupWvxHE8mEKnqYD0YjJZbKVYvuvpANr
	kIgMUGO6vzayJxPXQw147Q6lPJWH+mNy4U1JGruwsI=
Received: from [127.0.1.1] (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSkvCgDndzrmN+dp+62BDQ--.51846S2;
	Tue, 21 Apr 2026 16:40:06 +0800 (CST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 sched_ext/for-7.1-fixes] tools/sched_ext: scx_qmap:
 Silence task_ctx lookup miss
From: Zhao Mengmeng <zhaomzhao@126.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
 Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, 
 Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20260421071711.3108449-1-tj@kernel.org>
References: <59bc5171ee5aa02746c2f576d0f1e14f@kernel.org>
 <20260421071711.3108449-1-tj@kernel.org>
Date: Tue, 21 Apr 2026 16:40:04 +0800
Message-Id: <177676080441.287462.4429404493386690280.b4-review@b4>
X-Mailer: b4 0.15.2
X-CM-TRANSID:PSkvCgDndzrmN+dp+62BDQ--.51846S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr45CFWkuF48XFWUAFy8AFb_yoW3trcEkw
	43Aw13ZFs8tFnrCw43GryUXr1ftF4kWF95G3yjqrZxGa1rJrWDtF4UCF90kF9rXFs3ZFy7
	CFs5ZF1kKa1v9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRMSoGJUUUUU==
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBqgdb0mnnN+ff6QAA3M

On Mon, 20 Apr 2026 21:17:11 -1000, Tejun Heo <tj@kernel.org> wrote:
> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
> index b68abb9e760b..aad698fe294b 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -584,10 +574,8 @@ static s64 task_qdist(struct task_struct *p)
>  	s64 qdist;
>  
>  	tctx = bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
> -	if (!tctx) {
> -		scx_bpf_error("task_ctx lookup failed");
> +	if (!tctx)
>  		return 0;
> -	}
>  
>  	qdist = tctx->core_sched_seq - core_sched_head_seqs[idx];
>  

Hi Tejun,
I met this error also on the lastest for-next branch, trying to prepare a
fix and find your patch. Looks good to me.

Reviewed-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

-- 
Zhao Mengmeng <zhaomengmeng@kylinos.cn>

