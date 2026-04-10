Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A0033A6F2
	for <sched-ext@lists.linux.dev>; Fri, 10 Apr 2026 22:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775861936; cv=none; b=bJ5ypX86zqzKf+KHDW41t3HSQ3phKoLFJePmRfu3MFT8koGKFvxlfDg5PPVseg/Q/o6PgnULgVIM9j+xs2bzw6CciSr0sl5mRbzF2VReFHcgaOh7vhflh0Yzma8scM2k8pxGSakCqCY8cNH9D1xGO61ypCjegWnaCL7wdor22EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775861936; c=relaxed/simple;
	bh=qJbVzHmePHTXLglfgut/yQBPzC6BAP459GlMgUSeGbs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ngQm29hqBIBCmF0ye9A3IfuY1B+stCja+ESxGChjMc+tkqk12Yfyb+iuPvxjARQRL1t3Td5qrx8YYZt7vol4mS7GgjYhi8lb9zOXeOBpWbmycmEHTtEnQa/qzst+zx36m7JFBvNEgovbSy7A5LpJLN59jPKpl1qaYHZ5S7DBWHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=LX0+edg1; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="LX0+edg1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=E6Me02ZTj6dh7HVBpnXBiI4P2QkQolzaIJeCwPxdciA=;
	b=LX0+edg11M0Z8aA/gN1vsNZbj9On8MgzIvipc+C+kIuP1wFMGqkzxJqj4vkpQ5
	wF38AMVGOOEZiqgtihfZrmTZjJQH3irJwtdG+OYIsVytnW5Y2GilvyzVw9dVKQzU
	QXY5Qnn20Z2cm02sKOkXHfNVsDds2oKrE8iFQ5/br4ssU=
Received: from ehlo.thunderbird.net (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3B6iOgNlpPLNHBQ--.14247S2;
	Sat, 11 Apr 2026 06:58:22 +0800 (CST)
Date: Sat, 11 Apr 2026 06:58:21 +0800
From: Zhao mengmeng <zhaomzhao@126.com>
To: Tejun Heo <tj@kernel.org>
CC: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhaomengmeng@kylinos.cn
Subject: Re: [PATCH 1/3] sched_ext: Prevent CPU kicks from exiting schedulers
User-Agent: Thunderbird for Android
In-Reply-To: <adlZ9nHVKfcwly_H@slm.duckdns.org>
References: <20260409032126.114812-1-zhaomzhao@126.com> <20260409032126.114812-2-zhaomzhao@126.com> <adlZ9nHVKfcwly_H@slm.duckdns.org>
Message-ID: <EA6894CA-24CB-4A2E-B768-959D5CC129F7@126.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:_____wD3B6iOgNlpPLNHBQ--.14247S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr48Gw1DXryDCFW7XF4kXrb_yoWfJFb_ZF
	yqkFs2kFZ8WF4vy3Z3Kr4SqFWYgF1UJFW8Gwn2vF92kr9xAFyUWF4YkFZav3Z3JF4IqF98
	Ka1vva18tr9xtjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUVyI5UUUUU==
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBqw8Ui2nZgI9P1gAA3d

On April 11, 2026 4:13:42 AM GMT+08:00, Tejun Heo <tj@kernel=2Eorg> wrote:
>On Thu, Apr 09, 2026 at 11:21:24AM +0800, Zhao Mengmeng wrote:
>> From: Zhao Mengmeng <zhaomengmeng@kylinos=2Ecn>
>>=20
>> On PC with 8 core, when running scx_central with stress-ng -c 2 --io 8,
>> if enable/disable scx_central frequently, dmesg will pop an message:
>>=20
>>     [   38=2E214510] sched_ext: BPF scheduler "central" enabled
>>     [   47=2E809167] hrtimer: interrupt took 11287895 ns
>>     [   48=2E233813] sched_ext: BPF scheduler "central" disabled (unreg=
istered from user space)
>>     [   48=2E248460] kick_cpus_irq_workfn() called with NULL scx_kick_s=
yncs <---- here
>
>So, this is not really a problem=2E I think all we need to do it switchin=
g
>that to a debug message=2E
>
>Thanks=2E
>

Tejun, thanks for review=2E I will switch pr_warn_once to pr_debug and sti=
ll
keep patch 2 in v2, WDYT?

