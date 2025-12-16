Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44E33469FE
	for <sched-ext@lists.linux.dev>; Tue, 16 Dec 2025 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765898398; cv=none; b=cYQfthm3B/c8SaR93mZlvEeYnMpba5V4gmjPvfGn4dOpN4LSZgNGmL+Zcz/TavwoJ2k2T2aBDzJdUnV10zxnj/l/2ypFFLX8LTQ4gcvGh61eCm6lMhBTAvaPCDQrdo2+tdlkJ9PdUYkCk45NIcR7fLIVo2FnIdBh/mtxh3Xx+wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765898398; c=relaxed/simple;
	bh=kWN2MI6koeKtF8HsSKiv5FqBa6vC6RWlP5GfVuKDaD4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=tUx7cquo4R2fL3PdiXZG7aYoJa36K3kr2fDg2NvL9fl5vdlk9gSUnvKbQChtkQi49wvdsmvRCmfRbqDCyH6Uu9JqU/G3uLiz+HrZo7zECZVd74GI74g3SoGuXJYeZQyyNfzRJXnOQm666ke+oS7sXSXQyCZBmNhF7PAFax/OHL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=08xeMBHI; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="08xeMBHI"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-88a347c424aso30213486d6.0
        for <sched-ext@lists.linux.dev>; Tue, 16 Dec 2025 07:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1765898394; x=1766503194; darn=lists.linux.dev;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=de3zjk2T60rUddmors6D20z+BqVsAlEXYVeufQpJ9X0=;
        b=08xeMBHIfWzY8xwhwyi7jd/zoEitfg44KuRksx6Cxq3Eu7q1TblOvHyd5e2zS3blw2
         0ZPvmzYrwe/etJhZcACwT4rgdHho4nmTlfbZERmWwV8ZyVi2KyqRf0LtQvcqDY96XowD
         zUjLMAjsggc5+LoNXhFgoTEj6pqynBrgpauLjnpYfBdjsUk+Bvp/GaXp6RHWLzKZSTsG
         jRCSOWK8b/HKLhMZzYIDB7dl1kfHCh72fdOrJHV8dikv4P8NU/5RQF6/vkVUmC2mpGNr
         TLSOGFSr5XJs8fVfcvIaKO+aTCuEqI18CLsFBC3sQngjqfPTE1vNi8MQrgIinJTeyc/X
         2Spg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765898394; x=1766503194;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=de3zjk2T60rUddmors6D20z+BqVsAlEXYVeufQpJ9X0=;
        b=HFlGy4FUo5ZYrWG4VqxzYaR9XAfcLWbtNfsHFkOIAT4IpIMSuygZqS+uGkkgyDJnTb
         2Q3qj8fchuBR6wD2pTs0N3/ShWj9H5hhhN4mLEWXN/JuagzqvoW9ezPFZ4WZlbNF1Vcm
         MjlTUzGP0F3NvWwTDLbCVmKT2OWW5S4lbFodpWBcskGa+w+5muKryjlQ4MdZBqeoA91H
         3eoF4saIuZjZ3gV0qFHrwQUIzJYFXMvTxO6GsmSQRahS0SHKlQbi+8BjAVlMA4h0aSQ7
         uA9nFx2y2C/gHD4LYCAtoDx08FywonF+bR5h9/WfNiLftX5fAVyZtNVejXI+BMArKiCo
         Uzvg==
X-Forwarded-Encrypted: i=1; AJvYcCUgIfgHzkajinp0avqHRvfVWzfUXTtvImHGWcp2VxMFhkJMP8GHh2OKteQBxNrW3/kmlF67K4pA7XQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YyFGjCVDpKYXdOx5GCcgMRkx//vozUlNWaFTrlwc9hBuf37ODgd
	xWrBq9bpVDBbTp2rTmJem2v16ciBEON0dcRne7knOuwnkEqO729OyfzaMn0Luh90Nn8=
X-Gm-Gg: AY/fxX40J0oaC9SIrJeVdebynwm9KxUpbUvVsZx2pn2UK79E+rSmwhspAey+nxclQAz
	vdLqd5yU8kOZKwhMujc9WKWkevKG42tvEWFSbA8fp+bM0JlCby+wlwDyX1LKao5o6cm3HfxxIzB
	naNjcRno4EaccseCVY4jk6n9a+8byvdxa7IVMf6VcJ52vh8f7eVVhMqVSVs+Dkq+lfmRUAdP7eD
	zWxIIhcOwq2WHtLgwcwKBVVcRysZ7hi1QxS2p+mrCJBFFpvzN0dd8eaPFETH81GXVg+Jx4blSk7
	MqG91za55nNcK7Rc72Htx6A0E6IcklhZqoSYwAfy9U7uPJXghT1YRIYd/8ZA/CN9K08oM8/p9zO
	1JYX2IPuNx1bDWfPnseSmbr5Bkin1VOZM6J4W6e8D48F7rEjG6TCdJeSlDQEFom/+6XPYBvTsmY
	qfByrOvJ/epCA=
X-Google-Smtp-Source: AGHT+IEgQ4A3mnKdkt35J/Vxw0tq/W1jv3GLGeI7wstC8gZ0t+wa8jAv3mHNJ47OyvRfcAaLRhcXvA==
X-Received: by 2002:ad4:5fc7:0:b0:882:4632:cf7e with SMTP id 6a1803df08f44-8887dfe38c2mr215260436d6.12.1765898394528;
        Tue, 16 Dec 2025 07:19:54 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8be31c75e91sm204006285a.47.2025.12.16.07.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 07:19:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Dec 2025 10:19:52 -0500
Message-Id: <DEZQQIB8OGAO.30E5KVJMY54D@etsalapatis.com>
To: "Liang Jie" <buaajxlj@163.com>, "Tejun Heo" <tj@kernel.org>, "David
 Vernet" <void@manifault.com>, "Andrea Righi" <arighi@nvidia.com>, "Changwoo
 Min" <changwoo@igalia.com>, "Ingo Molnar" <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, "Juri Lelli" <juri.lelli@redhat.com>,
 "Vincent Guittot" <vincent.guittot@linaro.org>, "Dietmar Eggemann"
 <dietmar.eggemann@arm.com>, "Steven Rostedt" <rostedt@goodmis.org>, "Ben
 Segall" <bsegall@google.com>, "Mel Gorman" <mgorman@suse.de>, "Valentin
 Schneider" <vschneid@redhat.com>, "open list:SCHEDULER - SCHED_EXT"
 <sched-ext@lists.linux.dev>, "open list:SCHEDULER"
 <linux-kernel@vger.kernel.org>
Cc: <liangjie@lixiang.com>, "kernel test robot" <lkp@intel.com>, "Dan
 Carpenter" <error27@gmail.com>
Subject: Re: [PATCH] sched_ext: fix uninitialized ret on alloc_percpu()
 failure
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.20.1
References: <20251216093955.2928453-1-buaajxlj@163.com>
In-Reply-To: <20251216093955.2928453-1-buaajxlj@163.com>

On Tue Dec 16, 2025 at 4:39 AM EST, Liang Jie wrote:
> From: Liang Jie <liangjie@lixiang.com>
>
> Smatch reported:
>
>   kernel/sched/ext.c:5332 scx_alloc_and_add_sched() warn: passing zero to=
 'ERR_PTR'
>
> In scx_alloc_and_add_sched(), the alloc_percpu() failure path jumps to
> err_free_gdsqs without initializing @ret. That can lead to returning
> ERR_PTR(0), which violates the ERR_PTR() convention and confuses
> callers.
>
> Set @ret to -ENOMEM before jumping to the error path when
> alloc_percpu() fails.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202512141601.yAXDAeA9-lkp@intel.com/
> Reported-by: Dan Carpenter <error27@gmail.com>
> Fixes: c201ea1578d3 ("sched_ext: Move event_stats_cpu into scx_sched")
> Signed-off-by: Liang Jie <liangjie@lixiang.com>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  kernel/sched/ext.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 05f5a49e9649..8ea243b04dc9 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -4761,8 +4761,10 @@ static struct scx_sched *scx_alloc_and_add_sched(s=
truct sched_ext_ops *ops)
>  	}
> =20
>  	sch->pcpu =3D alloc_percpu(struct scx_sched_pcpu);
> -	if (!sch->pcpu)
> +	if (!sch->pcpu) {
> +		ret =3D -ENOMEM;
>  		goto err_free_gdsqs;
> +	}
> =20
>  	sch->helper =3D kthread_run_worker(0, "sched_ext_helper");
>  	if (IS_ERR(sch->helper)) {

