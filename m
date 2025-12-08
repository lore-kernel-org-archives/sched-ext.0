Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E097D3112B6
	for <sched-ext@lists.linux.dev>; Mon,  8 Dec 2025 13:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765200357; cv=none; b=MOh45GYHcKyDnDsQbVEFRDPaw5Q7f6jnv5tAcjysfqmvSav1V+AviG1QfEDjFJNdUymBJKLS1bjijMKu1JyEj2Cup0ycgZiPVMN9lDCFkWzui/5tOXzNH/gEmqQnjCCmWpjxHZI3JCRgTkOwl2Ng+8fZZq3QnlAUlvya9Ky5zMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765200357; c=relaxed/simple;
	bh=S3V9kwTvilE+pVIlkCSMhSsP8313VpAe7fro1QqD418=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=MScsjSKAzLpnsNMg3Jy0mKrRC/KxnfGzO/wNgkzfd9N9sxDankihiSHIiumvgdoohZbmowGZGFAoXSnR7LQQJLYBRve+tHo07JnaQYY7B+aKlSWfOjrsW0dY5lypoiD9HJcaXO+Npy4bijWjOnSvCxMQhMYOCbT0H1hP+wt6cvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p2Z0cZPz; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p2Z0cZPz"
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765200342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uHiYJrNXLJHo0brU6vl3dOowhEP2xWg232fAd4kzV0o=;
	b=p2Z0cZPzoLSzfGCgBzeOfhR0cibHlFZDHa+UsXSD/2EOYg48vpUeuQCpqt/dvQ1PLepk31
	Wue9T/rM1z2aeWL3sPWRxGfWCroWviV0c5eP4UZCPyv/pE1lillkOp3R2x8HG4YQQ6rq+Z
	/V9YqIcoFXhr3AUIIuQ6HnEJLL2ZXcs=
Date: Mon, 08 Dec 2025 13:25:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <6ce126d5e8262ff22b46fb11d368e23d72d911ba@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] sched_ext: Fix lockdep warnings in the ops_dump_init()
To: "Christian Loehle" <christian.loehle@arm.com>, tj@kernel.org,
 void@manifault.com, arighi@nvidia.com, changwoo@igalia.com
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <88d4bad3-213c-4486-b56f-da49ad458924@arm.com>
References: <20251208112320.27144-1-qiang.zhang@linux.dev>
 <20251208112320.27144-2-qiang.zhang@linux.dev>
 <88d4bad3-213c-4486-b56f-da49ad458924@arm.com>
X-Migadu-Flow: FLOW_OUT

> On 12/8/25 11:23, Zqiang wrote:=20=20
>=20
> > For builts with PREEMPT\_RT=3Dy kernel, the dump\_lock convert to=20=
=20
>=20> sleepable rt-spinlock and not disable-irq, the following lockdep=20=
=20
>=20> warning will appear:=20=20
>=20>=20=20=20
>=20> WARNING: CPU: 3 PID: 47 at kernel/sched/ext.c:4130 ops\_dump\_init+=
0x60/0xa0=20=20
>=20> Modules linked in:=20=20
>=20> CPU: 3 UID: 0 PID: 47 Comm: irq\_work/3=20=20
>=20> RIP: 0010:ops\_dump\_init+0x60/0xa0=20=20
>=20> Call Trace:=20=20
>=20> <TASK>=20=20
>=20> scx\_dump\_state+0x1091/0x1620=20=20
>=20> ? \_\_schedule+0xf1c/0x3ec0=20=20
>=20> ? rcu\_is\_watching+0x19/0xb0=20=20
>=20> ? \_\_pfx\_scx\_dump\_state+0x10/0x10=20=20
>=20> ? kvm\_sched\_clock\_read+0x15/0x30=20=20
>=20> ? \_\_lock\_acquire+0x98b/0x1ae0=20=20
>=20> ? \_\_this\_cpu\_preempt\_check+0x17/0x20=20=20
>=20> ? insn\_get\_modrm+0x107/0x6e0=20=20
>=20> scx\_error\_irq\_workfn+0xeb/0x120=20=20
>=20> irq\_work\_single+0x113/0x260=20=20
>=20> irq\_work\_run\_list.part.7+0x44/0x70=20=20
>=20> run\_irq\_workd+0x6b/0x90=20=20
>=20> ? \_\_pfx\_run\_irq\_workd+0x10/0x10=20=20
>=20> smpboot\_thread\_fn+0x34c/0xa50=20=20
>=20> ? trace\_preempt\_on+0x54/0x120=20=20
>=20> ? \_\_pfx\_smpboot\_thread\_fn+0x10/0x10=20=20
>=20> kthread+0x411/0x8a0=20=20
>=20> ? \_\_pfx\_kthread+0x10/0x10=20=20
>=20> ? rt\_spin\_unlock+0x9f/0x210=20=20
>=20> ? \_\_pfx\_kthread+0x10/0x10=20=20
>=20> ret\_from\_fork+0x406/0x500=20=20
>=20> ? \_\_switch\_to\_asm+0x33/0x70=20=20
>=20> ? \_\_pfx\_kthread+0x10/0x10=20=20
>=20> ret\_from\_fork\_asm+0x1a/0x30=20=20
>=20> </TASK>=20=20
>=20>=20=20=20
>=20> This commit therefore convert dump\_lock to raw spinlock.=20=20
>=20>=20=20=20
>=20> Signed-off-by: Zqiang <qiang.zhang@linux.dev>=20=20
>=20> \---=20=20
>=20> kernel/sched/ext.c | 6 +++---=20=20
>=20> 1 file changed, 3 insertions(+), 3 deletions(-)=20=20
>=20>=20=20=20
>=20> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c=20=20
>=20> index 59fa391636c7..2e19e3689f1c 100644=20=20
>=20> \--- a/kernel/sched/ext.c=20=20
>=20> +++ b/kernel/sched/ext.c=20=20
>=20> @@ -4235,7 +4235,7 @@ static void scx\_dump\_task(struct seq\_buf \=
*s, struct scx\_dump\_ctx \*dctx,=20=20
>=20>=20=20=20
>=20> static void scx\_dump\_state(struct scx\_exit\_info \*ei, size\_t d=
ump\_len)=20=20
>=20> {=20=20
>=20> \- static DEFINE\_SPINLOCK(dump\_lock);=20=20
>=20> \+ static DEFINE\_RAW\_SPINLOCK(dump\_lock);=20=20
>=20> static const char trunc\_marker\[\] =3D "\\n\\n~~~~ TRUNCATED ~~~~\=
\n";=20=20
>=20> struct scx\_sched \*sch =3D scx\_root;=20=20
>=20> struct scx\_dump\_ctx dctx =3D {=20=20
>=20> @@ -4251,7 +4251,7 @@ static void scx\_dump\_state(struct scx\_exit=
\_info \*ei, size\_t dump\_len)=20=20
>=20> char \*buf;=20=20
>=20> int cpu;=20=20
>=20>=20=20=20
>=20> \- spin\_lock\_irqsave(&dump\_lock, flags);=20=20
>=20> \+ raw\_spin\_lock\_irqsave(&dump\_lock, flags);=20=20
>=20>=20=20=20
>=20> seq\_buf\_init(&s, ei->dump, dump\_len);=20=20
>=20>=20=20=20
>=20> @@ -4375,7 +4375,7 @@ static void scx\_dump\_state(struct scx\_exit=
\_info \*ei, size\_t dump\_len)=20=20
>=20> memcpy(ei->dump + dump\_len - sizeof(trunc\_marker),=20=20
>=20> trunc\_marker, sizeof(trunc\_marker));=20=20
>=20>=20=20=20
>=20> \- spin\_unlock\_irqrestore(&dump\_lock, flags);=20=20
>=20> \+ raw\_spin\_unlock\_irqrestore(&dump\_lock, flags);=20=20
>=20> }=20=20
>=20>=20=20=20
>=20> static void scx\_error\_irq\_workfn(struct irq\_work \*irq\_work)
>=20
>=20=20=20
>=20This is already part of Tejun's cgroup sub-scheduler support series:=
=20=20
>=20[https://lore.kernel.org/lkml/20250920005931.2753828-39-tj@kernel.org=
/](https://lore.kernel.org/lkml/20250920005931.2753828-39-tj@kernel.org/)


Thank you for pointing it :),  please this patch.

Thanks
Zqiang
