Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794292137;
	b=NwlhjrZk0ZEYjc9/QlXi4MKNz2D6W9eF1IzMGtfSJbvDLFUouDosmrEsEWUWkSI9gYOV
	 YLR6eRNDJ4E92Ab2FlfQCXviNmORbyuQZoZXCrRL1z9dCz879S/hUQqCabW8fPuuHZD8Q
	 OAu93AHT2KqpSYpAcYGqbW0plukqUwhrbnXWCybwafdtCSM5b+XdI7cGerGHHd3lc1J5b
	 tZaqTlWVsRYxbjt3kG5ldAa7/cqEZ+R3M8C1vruCrykNF21QiOfL0MnDUjvdrB7kMDLRK
	 CZSx5STZurv0/KgpwTBZeAFI9wmoX5MQ/5EPz8e4K4GxCMeQtSyyK0+U9eDd0EogVVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794292137;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=RpfohSSDFEBS6Pgycm+c4TWN1kvCTWNeu8AxPgO4saI=;
	b=YWsOo6gQ0QHeeiWX2hqw1/SSAL3EYHmLQe3MUbn5xxJnWWDHuJBHm6yfoR9kXEo9B+Kh
	 jHz7Xgs62nIxHJOGUZNXJmZZJHe3E4RKe9BZ10iDPgsiXq8kxU+HvIFglRGIIQ4MiMUae
	 WYljBmgGC9/lM/ld+nwnqd3GoQx8c/0RPNaTtYaUSMeDOPNthVSZe5xVfeSzWTkIA7qYt
	 dEPBgiuI0h5/uTomV8xgm5gtVanz8ulv67O9+IGGW63ndbPlxrB8gZyv8+3xlirvaFFeM
	 9dnV31fFz/PDes0y561ACIPKO5CpJbzbEdqynA98X1yq/8MH3dUveU56Y3/ny7dbCqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=n+Hn1B0h;
	arc=none smtp.remote-ip=113.46.200.224
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FF9606A31C
	for <sched-ext@lists.linux.dev>; Tue, 10 Nov 2026 06:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33FF9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=n+Hn1B0h
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=RpfohSSDFEBS6Pgycm+c4TWN1kvCTWNeu8AxPgO4saI=;
	b=n+Hn1B0hNbDslZ7hyhpz0on0wsxDL2E4CgOvcrDV6Hkts5OL1N3wLHkWIUT3KoiXMKVqwL/QY
	d5UIS70Znp3TAsQIbEnGUiKvEnwGiC0nfsvO5I7XFBE5UD2z1vLuczCc2ijGxhilGJzA3j250ck
	rR/r0fDN7J5zMXupCYk/cMA=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4jNxYW5542z1cyRv;
	Tue, 10 Nov 2026 14:28:31 +0800 (CST)
Received: from kwepemk300016.china.huawei.com (unknown [7.202.195.98])
	by mail.maildlp.com (Postfix) with ESMTPS id 8108A4055B;
	Tue, 10 Nov 2026 14:28:46 +0800 (CST)
Received: from [10.67.109.218] (10.67.109.218) by
 kwepemk300016.china.huawei.com (7.202.195.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 10 Nov 2026 14:28:46 +0800
Message-ID: <cac942a3-e98f-cf5c-09c5-71c1f53d0ba7@huawei.com>
Date: Tue, 10 Nov 2026 14:28:45 +0800
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH sched_ext/for-7.4-fixes] sched_ext: Fix partial-SMT core
 counting in calc_shard_layout()
To: Tejun Heo <tj@kernel.org>
CC: <sched-ext@lists.linux.dev>, David Vernet <void@manifault.com>, Andrea
 Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Hui Tang
	<tanghui20@huawei.com>
References: <1eac08a9-b5e9-b353-b9d1-1e2d32802993@huawei.com>
 <8b54675a18fdf659a1c913784d5a27e9@kernel.org>
From: Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <8b54675a18fdf659a1c913784d5a27e9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk300016.china.huawei.com (7.202.195.98)



在 2026/11/7 2:48, Tejun Heo 写道:
> Hello, Qiao.
> 
> On Fri, Nov 06, 2026 at 10:44:30AM +0800, Zhang Qiao wrote:
>> A core is counted when its cpu is the first cpu of
>> topology_sibling_cpumask(), which includes offline cpus. When the
> 
> AFAICS topology_sibling_cpumask() includes offline cpus only on mips and
> sparc64. x86, arm64, riscv, powerpc, loongarch and s390 clear an offlined
> cpu from its siblings' masks. Which arch did you hit this on?

No, this was based on code inspection. I incorrectly assumed that sibling masks
handle offline CPUs consistently across architectures. MIPS/sparc64 can retain
offlined low-numbered siblings in the masks. Also, on any architecture, siblings
may fall outside @llc_cpus. The count should follow the build loop's actual
logic, so v2 adopts your comment.


> 
>> +		/* the low-numbered siblings may be offline */
>> +		if (cpumask_first_and(topology_sibling_cpumask(cpu),
>> +				      llc_cpus) == cpu)
> 
> The comment describes one scenario rather than what the test does, which
> isn't very useful. Can you state the rule instead? e.g.
> 
>   /*
>    * scx_cid_init() forms each core from the siblings in
>    * @llc_cpus. The sibling mask may include cpus outside
>    * @llc_cpus, so count a core at its first sibling in @llc_cpus.
>    */
> 
> The fix looks right, but the patch is whitespace damaged and doesn't
> apply. Can you send v2 with git send-email?

Sorry about that - v1 got mangled by my mail client. v2 follows via
git send-email.


Thanks.

--
Qiao

> 
> Thanks.
> 
> --
> tejun
> 
> .
> 
