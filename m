Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2040B1FE45D
	for <sched-ext@lists.linux.dev>; Fri,  6 Feb 2026 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770393830; cv=none; b=OOq8mThplZvEjFvckq1miyDNjCiI8ucermgmwNzodyGxF+vXP0zugniJy+JtQUY2ariENMas9pxKMsnVi1Yg5tW1ABo5nhsNmwy5bTqyYN8X1qBCyf7DfegmhFtla6WxnFjjgvWljzgFuLXrE5JMXY75LKZS+SDc3Q8tVXzRJCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770393830; c=relaxed/simple;
	bh=TbrawEUsDjR3mpknDdoOmynywFBENFZE9bKHznZcqpE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bXutNFHV+vajqCgQV47l07qGip0VKHmEXUDOeZGAIyDYx4wgEuPsUUj8/BZKYTrtSldu/zyc7Utpr2ALGAvpw8axfI36oIYgA+/fyeZ7vLc7xcmhRPqISf4otVhZq11hmVkN+i4meQsd2yKepHIUU6W+csHragRi7PgL6rgfgFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=nPzJZtZB; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="nPzJZtZB"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c6a822068eso112234485a.3
        for <sched-ext@lists.linux.dev>; Fri, 06 Feb 2026 08:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770393829; x=1770998629; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEX6o9ONgTf923ExD7WYIz+0S7kT8YvB8ztho8evgKI=;
        b=nPzJZtZBEiLwVYD6p3UXmgRLXMCME0I12zWr/1727utStIkMTeSZQLVj37rHe9GZsj
         D9ltRSTRFMXUvz2mOqTsbzEfRnF7fGMaYQvNojiAQFsGMTMs69C0tPOBI1LeE+WYLDZw
         kwvnKXQPt8f/XWTPa35/EgM/og5dscWYjqZd7T7X2erlCdhWy8hOiZg2xVbVlaxywUqv
         WJ1dZHiNxdDd4snJeAyzBAk7LpAwBi4K7qpElPyOMEPR13PAblIH/Kcx/jpv3LVqxV9/
         dWpylP8+gu0vVXK1Fbh7U72kFVNaeaWZz3Yd3/d54ix6zIT4VJKNOUW5O8MIMvVcQrjJ
         B/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770393829; x=1770998629;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rEX6o9ONgTf923ExD7WYIz+0S7kT8YvB8ztho8evgKI=;
        b=vQebHDFcqC/CRcE2lM1Zk0BkVl0iA6PChVol/5LGKNRuCFDfGV6nqdga3MwVTPpG1p
         hpt/lqznVfJhv4mSPHJ6PhYEmOxD9V8JShgMUpNolCZgbWKHojxXtTRnBInUBafQICWZ
         HoOS2DkltTl/11DXDQAvbmURrjnkiuGahtGiZ3srp9vRlkQfa82vwVDB1BXFz3cvB0Hs
         DptQwZWVnNPyP3KFnNfHUA8Msd39li7s6iULtDjJhGvjir9UWdZzC2jE6nOJEb2dOCRh
         XYjUpmJkz8+E293oOUZObDx6h5FmohWoJJ9fgzVyT4rT8BVe7LOpPbVqunD70t59LBz6
         cC7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIFY335l7MYgH8WH6xppp1EQZMC+484DGlkg8F6tKyVYEqUwVxBcAwCyiHWqGGzUdGknUdOtm2F6w=@lists.linux.dev
X-Gm-Message-State: AOJu0YygBCvn8P3uOPkHiMePx8ZA+Waxddd1ES81CRh6AgsJxZlhpTjO
	lZLkKAPva5vYplnLHhxMDYxgafyhUZ7B7UX7SMzs6eEDbg7/pphMb0b6xoES1wSUO6g=
X-Gm-Gg: AZuq6aJsrP6FOAPs4H3oDpVfOEp45uCG6J6eBaq1yuA5mFmBgF7LEa3djo5L02LiN5E
	jDJvNw2epNbAhmNHuwlO1e6FfJyVhB4w3Mr+nxgvrZPEiWyPnTq9NKTOVTIH7I4jj1SweJy6fi3
	KcAH4CbGWkBDIKPKfKhJwXjUC/KteRD1xgi9v6IgINgfVVZ/oN1ukV46LF+4fu7Ttx5UOzlBtSu
	j3hLmbRmr03ulE16RZ97NdZC1AxR+KhaqfTsnPXm1L6l/4brkMFNQbf21uSmKKUJTzBaqyeAIG4
	1JiYsNwr0ZbSirS4hpICg1LIp5/8xU6wyXGrN+nlqi+QPcKrhtX3lYM+CqpbMj0X8PtkSED7qEJ
	u3PiBS49IZxl/JptXk8o6xuPNiUOOZqN/JwGdHOkR6vos8r8waiJdEXohKd77DStVnjYjAhQxcT
	x47lSYRhwnw84=
X-Received: by 2002:a05:620a:4589:b0:8ca:3562:c0fd with SMTP id af79cd13be357-8caeef2fb03mr467050285a.5.1770393828689;
        Fri, 06 Feb 2026 08:03:48 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9fdf745sm182467185a.40.2026.02.06.08.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 08:03:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Feb 2026 11:03:47 -0500
Message-Id: <DG808GCYJ539.2UEZ50Z9R7ERU@etsalapatis.com>
Cc: <tj@kernel.org>, <void@manifault.com>, <changwoo@igalia.com>,
 <sched-ext@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <suzhidao@xiaomi.com>
Subject: Re: [PATCH] tools/sched_ext: Improve BPF verifier arena detection
 workaround
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Andrea Righi" <arighi@nvidia.com>, "zhidao su" <soolaugust@gmail.com>
X-Mailer: aerc 0.20.1
References: <20260206041808.170926-1-suzhidao@xiaomi.com>
 <aYWSSVDwOYEruRb2@gpd4>
In-Reply-To: <aYWSSVDwOYEruRb2@gpd4>

On Fri Feb 6, 2026 at 2:03 AM EST, Andrea Righi wrote:
> Hi,
>
> On Fri, Feb 06, 2026 at 12:18:08PM +0800, zhidao su wrote:
>> Replace bpf_printk() with volatile access in scx_sdt scheduler's
>> BPF verifier workaround to eliminate console output while maintaining
>> the required LD.IMM instruction generation for arena detection.
>>=20
>> This addresses the side effect issue of the previous hack while
>> preserving the essential functionality needed by the BPF verifier.
>>=20
>> Signed-off-by: zhidao su <suzhidao@xiaomi.com>
>
> Adding Emil in cc.
>

This still doesn't pass verification for me. @suzhidao is this working for =
you?
If so please let me know your setup so I can replicate this. I am
running this on for-6.20.

>> ---
>>  tools/sched_ext/scx_sdt.bpf.c | 18 +++++++++---------
>>  1 file changed, 9 insertions(+), 9 deletions(-)
>>=20
>> diff --git a/tools/sched_ext/scx_sdt.bpf.c b/tools/sched_ext/scx_sdt.bpf=
.c
>> index 31b09958e8d5..13d3060c99ff 100644
>> --- a/tools/sched_ext/scx_sdt.bpf.c
>> +++ b/tools/sched_ext/scx_sdt.bpf.c
>> @@ -64,14 +64,10 @@ DEFINE_SDT_STAT(select_busy_cpu);
>>  static __u64 zero =3D 0;
>> =20
>>  /*
>> - * XXX Hack to get the verifier to find the arena for sdt_exit_task.
>> - * As of 6.12-rc5, The verifier associates arenas with programs by
>> - * checking LD.IMM instruction operands for an arena and populating
>> - * the program state with the first instance it finds. This requires
>> - * accessing our global arena variable, but scx methods do not necessar=
ily
>> - * do so while still using pointers from that arena. Insert a bpf_print=
k
>> - * statement that triggers at most once to generate an LD.IMM instructi=
on
>> - * to access the arena and help the verifier.
>> + * Workaround to help BPF verifier track arena usage.
>> + * The verifier needs to see an explicit reference to the arena variabl=
e
>> + * to properly track arena memory usage. This generates the required
>> + * LD.IMM instruction without producing unnecessary output.
>>   */
>>  static volatile bool scx_arena_verify_once;
>> =20
>> @@ -80,7 +76,11 @@ __hidden void scx_arena_subprog_init(void)
>>  	if (scx_arena_verify_once)
>>  		return;
>> =20
>> -	bpf_printk("%s: arena pointer %p", __func__, &arena);
>> +	/*
>> +	 * Use volatile access to generate LD.IMM instruction without
>> +	 * producing console output like bpf_printk does.
>> +	 */
>> +	(void)*(volatile void **)&arena;
>
> Makes sense to me.
>
> If we want to be extra picky we can do something like this:
>
>   volatile void *arena_ref =3D &arena;
>   (void)arena_ref;
>
> In this way we take the address of the arena map descriptor and store it
> in a volatile void * variable, so the compiler can't optimize away and we
> never read the content of the map descriptor, we only use its address. So=
,
> we're not reinterpreting the bytes of the struct as another type (no type
> punning, no strict-aliasing violation). Even if it's probably just a
> theoretical thing.
>
>>  	scx_arena_verify_once =3D true;
>>  }
>> =20
>> --=20
>> 2.43.0
>>=20
>
> Thanks,
> -Andrea

