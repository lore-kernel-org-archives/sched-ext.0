Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBA130C63B
	for <sched-ext@lists.linux.dev>; Tue, 14 Jul 2026 03:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784000200; cv=none; b=XHIObxCWF1AW54UFbuFS2vd7b822Lu6N4l5f/TwXZ6XscApWIBBI9bezEQ13LIQjSibW4YXgnXlj8UxeEvaufIqvAS1k8etQkclUdTi59WgSXqvc1NnPw/x0cqryO9/zApPvKBfZ1ToaFUBeCaxJWqWbBdbnskwt9avJhdq3jWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784000200; c=relaxed/simple;
	bh=RLJl2QN0aWmHCCrxH0baI8DlMu2mxkJdxXrW0rQTWAU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eTSzGGRfKWSazjAnW+/A1o+AFGyZntLKYsQfUB6Cr3l7OCt/pCqYE/GpIPyqYew8H/psyIA284oU7BOIBOcKWZGjKx4fHtkZoXWOQA5xyzZ+YCj7yUtpY2ng1RjRDtMhOjM8WwlkSPfUUqRopRYiTlDOUr/YbXKZkXW+/WG1Qik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sTgQs6pC; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTgQs6pC"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso2351777a12.2
        for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 20:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784000198; x=1784604998; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gAuM5M3KA28cxh47JFCQwmkbYWzL0Rnh2NzqCwCHs/Y=;
        b=sTgQs6pCckBAe26Uwb+9Lzg4S5fUpIvWga0B0lV0WcFX2BwmdrCT0QNI9z2S2NPEl/
         6HCCEMAU7Z2sK7Dy4yUVuRyQp5SqQ6Z4z4Uat8Zp/iBtsf+h3PqACbPEH63JWhWrl880
         exbfZ69GnK2x/8hfKnpsqVyup0HFrbteAPL6TTWx+8EtFx3J90UFRFpPWpffg9OD1FlT
         Mw9BX7BK6wNpSpUBdGZMQg9Y4yNn4ripDkNTM2zdrNNolK7dxujiFlVF+PC3XdPDsB/Z
         0Yb8NEiCR+QzOdiSMDjxN7ukoMhywiDTtzt9Xez7oNpBFzzSOuy2Ef0JZP5+/enNAkas
         tKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784000198; x=1784604998;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gAuM5M3KA28cxh47JFCQwmkbYWzL0Rnh2NzqCwCHs/Y=;
        b=inZYOvwz+J5l8FEXje2wOva5lnxvsi8sr8cN5U0o1jg+oSbmJv0Mq6akawIBS3XJCE
         XXIsW7IVPVBod3uy7IU6SbhrwhHrtU6RBLGBnvPGHimq6h5kPRPieFf1P/qx8FVFjTej
         lUV/ypgxRzRbojbEItG2fQcWu8/db3PnoP6CBASjgUnbFB9IvZwFTr8Qa0fXfO6H78UA
         vWFNmpAsv2NxYIqRIimCamC1GJ6kk8y6925ASQMX5ADiWoWUVrqu1eExrOw8zA0ZbuYj
         u+YV0GTSRVw/72yQr0KNVvtezrIIAa0uEJ9pBKPTRBW+VB+fWDL7K59b6IbWxZqDBMMH
         jkiw==
X-Gm-Message-State: AOJu0YxPjlE2Fv8SXnpLgHGqZwOLH0IUb/au6QZfVEr78W3sGHo8GrFs
	EmLCJvP+96c2/q4Vs4dq/p5O4m2xO4vCd0EmmrrAJAeB/jdZtNzDhs4hb9XtGA==
X-Gm-Gg: AfdE7ckG8XuAlgyylK2J1WHaKQVJ4jULiUmfAan6Keuv1xKE9KJESCqOcXGRe8o4kDH
	shkr0S5Psx5SH33e5zFQ0UlT0Cliwg70imexpq1NE3XfyLcEB/dykLmC+XPKaMF8UyT+hgQl9sa
	3JLhzMjfpoF3z6mbqITnMwe6XJiPJ4UDbLzr/OjQZQ6ZnqMz1yipuljLAUmoORa17s5REIZHSwC
	UUbjfcB4ouP+SqpHrOETt0UGapzzypHt0jiBWTjHWplBCeDvayNK6eo4uAEs6PqEej9/GTKrhGy
	imcfBUBI5cVpbcNo2COPLgCqKo0MeLuaZ/Z1Yz12Yx1M04T2tA04+hL4MTcLDCEtNW/OMcEn93m
	Su7T/dWEOQ/dM6Da8AwvKyMARiIHYa+FVQCTolWDj4ok3eQ+By0UVviL4Soamroj+Pl2gpkK5gw
	5rz58puKyZPIJoPBTd8Nt1N2+mmc3UHogIARhHQMQPoNnzew==
X-Received: by 2002:a05:6a00:f89:b0:842:2419:6c0b with SMTP id d2e1a72fcca58-84889637ff9mr9302291b3a.10.1784000198378;
        Mon, 13 Jul 2026 20:36:38 -0700 (PDT)
Received: from smtpclient.apple ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f242999sm723429b3a.1.2026.07.13.20.36.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2026 20:36:38 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH] sched_ext: Validate cid override before updating tables
From: zhidao su <soolaugust@gmail.com>
In-Reply-To: <20260714025524.04EA31F000E9@smtp.kernel.org>
Date: Tue, 14 Jul 2026 11:36:24 +0800
Cc: sched-ext@lists.linux.dev,
 bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F5759324-507F-435F-A29B-CA8B1CC40FA9@gmail.com>
References: <20260714024704.3318132-1-soolaugust@gmail.com>
 <20260714025524.04EA31F000E9@smtp.kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3864.600.51.1.1)

Thanks for the review.
The current in-tree caller passes a BPF .bss array populated by =
userspacebefore SCX_OPS_LOAD, and doesn't modify it afterwards. The =
kfunc is alsoonly callable from the root scheduler's ops.init(), so the =
mapping isexpected to stay stable for the duration of the call.
If we later allow a different input source or concurrent mutation =
duringthe call, we'd need to cache the validated values before updating =
thetables. I don't think that's needed for the current contract,

> 2026=E5=B9=B47=E6=9C=8814=E6=97=A5 10:55=EF=BC=8Csashiko-bot@kernel.org =
=E5=86=99=E9=81=93=EF=BC=9A
>=20
> Thank you for your contribution! Sashiko AI review found 1 potential =
issue(s) to consider:
> - [High] Splitting the `cpu_to_cid` array validation and update into =
two loops introduces a critical double-fetch TOCTOU vulnerability, =
allowing an out-of-bounds kernel memory write.
> --
>=20
> --- Patch [1]: [PATCH] sched_ext: Validate cid override before =
updating tables ---
> commit 3a1a6d6109297fa0a7f1d91d2dccc68df1527d12
> Author: zhidao su (Xiaomi) <soolaugust@gmail.com>
>=20
> sched_ext: Validate cid override before updating tables
>=20
> This patch splits the validation and table updates in =
scx_bpf_cid_override()
> into separate loops. This prevents partial table updates if the =
validation
> fails midway through the user-supplied mapping.
>=20
>> diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
>> index af83084ec740a..e398e3f209bd4 100644
>> --- a/kernel/sched/ext/cid.c
>> +++ b/kernel/sched/ext/cid.c
>> @@ -329,6 +329,11 @@ __bpf_kfunc void scx_bpf_cid_override(const s32 =
*cpu_to_cid, u32 cpu_to_cid__sz,
>> 			scx_error(sch, "cid %d assigned to multiple =
cpus", c);
>> 			return;
>> 		}
>> +	}
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		s32 c =3D cpu_to_cid[cpu];
>> +
>> 		scx_cpu_to_cid_tbl[cpu] =3D c;
>> 		scx_cid_to_cpu_tbl[c] =3D cpu;
>> 	}
>=20
> [Severity: High]
> Can the contents of cpu_to_cid change concurrently between these two =
loops in
> scx_bpf_cid_override()?
>=20
> If cpu_to_cid points to shared memory, such as a BPF map, could =
another thread
> or BPF program modify cpu_to_cid[cpu] after it passes the validation =
in the
> first loop?
>=20
> If this happens, the second loop would fetch the unvalidated value and =
use it
> as an index for scx_cid_to_cpu_tbl[c], potentially resulting in an
> out-of-bounds write.
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/20260714024704.3318132-1-soolaugust@gmail.c=
om?part=3D1

