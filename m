Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B2C2BE630
	for <sched-ext@lists.linux.dev>; Wed, 31 Dec 2025 18:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767204575; cv=pass; b=PbnRKNKDhcgEnzK5XsWXCBH1qbELunlPPOCH+nVEM87K2+bNSGxWfPIQDQOiZQebHs84JDM7z4BrubS0A5tgaCNlWQ7SjdXh4Usv1J4MfSxmNpG1n7k2oCwk3kwGiBBoGWySWdcqa5d4WR6/WRn7tyYDFY+k/xhCGlPTIeV5NvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767204575; c=relaxed/simple;
	bh=Mtz2A8tWa233gsaBDZq5niJH69EnDrxIcs8csRo3gmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HFmC+kmRfjRP2VSApbEfmkYyuMlpKPXX+FLNMarqMaBCM0I6pgmyIR8X+Ve+l+fg9NrQ7np2X69F4W7CcEvnioyiIzJ8N8h8lyAmR93yawiYjWRGyPvgVcVpxtoTrZMIhupsoglM4z128wjoKembAFCpHHhDHZlxstwUE+7yNY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fY6dcyRr; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fY6dcyRr"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c2a00109fd8so253202a12.3
        for <sched-ext@lists.linux.dev>; Wed, 31 Dec 2025 10:09:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767204571; cv=none;
        d=google.com; s=arc-20240605;
        b=Q/DS1MO6Lu8JL/qFpAyYYgkmyIlw1tXxt/lea0vXYRu7raSYKN9ehpZSBBCAdSXAMu
         svDsO76PuM3CGH/YkTaef5GILw0uSfs/rBYU/Dlbm8HEQ7u6Pr/A7NdHepBPxg1uGMNr
         YA30t0xmlUuLk5rBaCcg5afS8DNU1lKon1eNhltFBUQC7OvwymXLprU+foxUGelbb9x+
         41wBrNPUTm0mBLHfSQguDnW/lKxSFHjICjxMm6Gx+YZ/SLw2nUceXMJDMD67vSj7crwI
         JhuX0C+xAE6DsWDTtUXUn4n5sEp/RYKI/fYM6LBcqmK0lpRiTPpZd0MmUgJ+AxkVhfsC
         x0mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bIMPl7WzuufPEFhizw2OC5bzIw2A/w2Jw5N6sXr/zUI=;
        fh=r9AsN2rJtxDJPi/DxbMnOWHRVawr4U59HJ7gAos616w=;
        b=KHJu0tShliGUhQ7V97ctZ49F2gz4RciuHPUXJGFLduvAxNNfeP/D6mbhWoubqDkFUC
         z5k+mTEFR5Na8F+CQs6UMTQTEjm03QdLhsd4KV1/0FUsEg2AaWpOK2cWhcFhY2CXdblk
         Wu0+YILZasiu84JGh9qa1yOyCAuHvxTGseEOUohL/0c/eWDeVUyjBvmeo6jSc+aD22H6
         uD/3pQeb6kbsbk3Y1bem5GfsjIx3u4Fyj5yHUMG9eQoKoL5p/QTE55a/vX0Vd0u9Gh9h
         oPwHbIEaedp8OOc0GGG3wI9DUo+Zal8MFRw1h0VhXeqO8tmpYe8HANSA0LC+lrx+j/mu
         h5lA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767204571; x=1767809371; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIMPl7WzuufPEFhizw2OC5bzIw2A/w2Jw5N6sXr/zUI=;
        b=fY6dcyRrRw2GFIE9yYRdARPugOOMsICHU4l73smD+kz3jvLx8beevnDtG/IrWMLfks
         JTV95feBhFId4EvGH0WH639SQSH9GEVx9naJFYpUu/6FAUef5GWJsR8jnGAeStdb1bl1
         cvsKoCp86fBNPc2WTkrlybI5VlyJZIuCXCMlJiGseoyo3aMIZBQB7G8u72lNDf3N0dPW
         sQtAIyuYCtVwBTmec4KeauFnhq6FzvZSB4QEziS39ONIg6z5CZLTNvXoyXB3GhEd9Gop
         /W+NE6sq9UkDdnr//Hixj7gKcaskacSZmokY0npmIuqopis0ZT2l0IVl5q9L83PzJmps
         7zzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767204571; x=1767809371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bIMPl7WzuufPEFhizw2OC5bzIw2A/w2Jw5N6sXr/zUI=;
        b=jL5ffPGHFSHI+Mx9O7lCrIAF0MIFasvinNE3vwzMQMlokXK33eAFsZbRPpVfuejeS/
         tq5iVoxGjesKWQ7LzGIGRc3jdnMF4YRZEQU8zTxdODbbqp0VNdCWxWMWtasacck89kyU
         dnHWKhIaPR+SpOWrd5v4FQPk2E+WziEOq/C6VdXLeB4xYrc1ldXOkKNyNTLvrSrERUgh
         qxquLmnHXpJkUJKOC+fypIFWN7JhLglTWGpM3sXDlWOZJvGz48KOVnuuuuWnLKN58e6u
         BgxTVXn/hbQmpRAkO7+Mmd9POCo9NL60ZG9FXc2ynrCy+/ny0aPTBmUeRGNJ5R9ctwfz
         yv9w==
X-Forwarded-Encrypted: i=1; AJvYcCXWmRZ01GI7RlSWRP6XJ0xBfCWxSn+HyqXQbOSazQXqoBa9GGxSHzku1n7QrrAsS+CKtP4LB08pAp4=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2qcjhdjwM4Ever46GaxgHb1miB0I3miz8DML/2WnfWD2hP9MV
	V9Hm8D9e1GwUjqjJWKHGbvIbGcc2Ci0TNbx9B0vDSh8BJKfH395vSBSKx54EPxi17QD2aaglu6t
	vNcRFDogOElnV7+MAi10FErG4+HmPtHfIDHgUFjoxBg==
X-Gm-Gg: AY/fxX6q/Kwpx0HWwH0R7QVjLRGiUvnJDUscU5X4C2z3Ip1POE6iU9aTm1g2ptJ7lcH
	CysUopuzhG7zDFsBnMpbpMgAcHbWki7NVRyd5humwJ0UJo1XRwZ7Rpati3LPmbBOCkgHFIl+Po8
	CkJ8W//FXppfEW+1Isx1dXimAcC6HAegWjZypwRV+7+CPbM+dKE6TbyT7va+WMSNHh7zEOsKQPT
	gjifFZsKO2G9wGUXiZkB5SKOcVXsOvJpy1hmTAOi4M9KrEvMsOHpIhxjoDgmnw93d4b2xbK7bdz
	Q/omZWI=
X-Google-Smtp-Source: AGHT+IEoQb+VMYUZF/EVHfCupM/J7UKB/HyklpfhaHst9+Iqt6sXvQ7lmZWvrOhCEyHebOWe5s6vxpHZd7OfrJbc6Sg=
X-Received: by 2002:a05:7022:6194:b0:11d:faef:21c2 with SMTP id
 a92af1059eb24-121722b44b3mr19049815c88.2.1767204570391; Wed, 31 Dec 2025
 10:09:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251231173633.3981832-6-csander@purestorage.com> <e9a1bd633fb4bb3d2820f63f41a8dd60d8c9c5e3c699fa56057ae393ef2f31d0@mail.kernel.org>
In-Reply-To: <e9a1bd633fb4bb3d2820f63f41a8dd60d8c9c5e3c699fa56057ae393ef2f31d0@mail.kernel.org>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 31 Dec 2025 13:09:19 -0500
X-Gm-Features: AQt7F2q8qmB_ZWyKhj1fKhcgEDCzRqBwfvvrWtG8WY5Jchb5VzTDRzCjSxJzD0s
Message-ID: <CADUfDZpSSikiZ8d8eWvfucj=Cvhc=k-sHN03EVExGBQ4Lx+23Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] selftests/bpf: make cfi_stubs globals const
To: bot+bpf-ci@kernel.org
Cc: jikos@kernel.org, bentiss@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	tj@kernel.org, void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	dsahern@kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	sidraya@linux.ibm.com, wenjia@linux.ibm.com, mjambigi@linux.ibm.com, 
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com, shuah@kernel.org, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, sched-ext@lists.linux.dev, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 10:04=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/too=
ls/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > index 90c4b1a51de6..5e460b1dbdb6 100644
> > --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>
> [ ... ]
>
> > @@ -1275,7 +1275,7 @@ bpf_testmod_ops__test_return_ref_kptr(int dummy, =
struct task_struct *task__ref,
> >       return NULL;
> >  }
> >
> > -static struct bpf_testmod_ops __bpf_testmod_ops =3D {
> > +static const struct bpf_testmod_ops __bpf_testmod_ops =3D {
> >       .test_1 =3D bpf_testmod_test_1,
> >       .test_2 =3D bpf_testmod_test_2,
>
> Is it safe to make __bpf_testmod_ops const here? In bpf_testmod_init(),
> this struct is modified at runtime:
>
>     tramp =3D (void **)&__bpf_testmod_ops.tramp_1;
>     while (tramp <=3D (void **)&__bpf_testmod_ops.tramp_40)
>         *tramp++ =3D bpf_testmod_tramp;
>
> Writing to a const-qualified object is undefined behavior and may cause a
> protection fault when the compiler places this in read-only memory. Would
> the module fail to load on systems where .rodata is actually read-only?

Yup, that's indeed the bug caught by KASAN. Missed this mutation at
init time, I'll leave __bpf_testmod_ops as mutable.

Thanks,
Caleb

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/206242=
06229
