Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3E138A73B
	for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 15:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783955972; cv=pass; b=KjybIicTxtvFFBX+m1w6cX5yD48MFri8fPCiWw6XotL50wb4ypUmJSZ8/cS05yHjL02Jpa6gQT5Hvr9dZwoo4esvnt6gMIOQfzqp2O7ZUfw8V9xdr54zDXanVGkctgAS6Agkym+qYnh2kf4v2UDjyeFICWEIVKrmZ/IDZ88rI24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783955972; c=relaxed/simple;
	bh=sEE3FMqOqkgJ0LjaW8o88lS57GWwQKCfWUiiHh0s0hA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvYunOR1t9AfSlHoYJYdajvZxO0KvkmBTjWF9tDXV3S3ts/9rioTg9lN1aDLLU2LBhVrm9lfE33fL7LX1VW8q8Hbv4IXXECaac/QffdIeR8LHdxxm1n/0Rg/wgDqy7Z0dFBow/kkZZbJuKchdtOFsAuOdUUwnOazdcKKcTkX5Gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MXTqlHGg; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MXTqlHGg"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so5896a12.1
        for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 08:19:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783955969; cv=none;
        d=google.com; s=arc-20260327;
        b=bUxPLcPB+UgQBReAGaOBRSrnFBGNdoOKUDTiJNFmtptEoq115mtN3G5XZyB449b5w7
         RDp4KquPfvJmZTfbGB7EFufbJoJxJk4TmH1vPdoGQnkVpATJiY7WR+nJhgIRK41FK414
         IIHuOAg9IPh4xRWQI7pAng5DtVKrUPLNzL5//wGEX+W6Dc2YxFCeQU00JCKaQ4AvqBBq
         BFaa3VAQhD5uOh8cjLdgBg6nNJ6/Q32dGX+4Q6P23PugykoY7e1IffTwHAZaJvY0ZPkv
         bFj8pKz2II7NLgV2hzYVVXkxaU/Q0HuC2aruw4eH0Fro2/g35SEUs1mICUpk1xWVw/na
         ITMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FG71CBoheueQ+381OlVy9pD30LVk3nyO1mhdOYTqr5E=;
        fh=braF4UeXPDDlx18jyG1wOtdDX6KDgC6eyfBaoumm0Dw=;
        b=rX1XOB0Fi9WGN3+a0yEE5aCNB1G2A39+a3rfusj9NBKpbk99Qoed9upyRZISxXGNG6
         oNH/mQgu8AkBUH5KyGSxZdGYe+aHcZgct/u9RPpVQlUv38Z2C5nQagx1DPiufSXnrDMb
         pxw4P18t9JTNFNIQ1uktW5EwLBUom7+meUjrqKQ0Q9r6+BMnKw+SVgoWse/MOCln8IkB
         kqgY5hbjotULlKRKK9hJhBXSxm7MYfMdZHZbdK8BoahB1/dWxu81F2Yc63Ja+9VB+971
         WP6kSLRctThTCPrlwBI+zSIZanNK7TbreaFGaguKoWsG2TEsAh5/tPTz7eWiH6OCGhvH
         FmLQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783955969; x=1784560769; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FG71CBoheueQ+381OlVy9pD30LVk3nyO1mhdOYTqr5E=;
        b=MXTqlHGgKzlqflmimdg2Rgz6QRHRUFMO0/wyxBNIswYzLExIM7JFJfcY1iWllc4w00
         9BQ1I54/xk5Bm0ae2J4yk8hCSPIFn/qpeEhomA/ISmvcXkdEn98VUigbTHoKEDR/S4fh
         ki2RwUQBVKS3elbZeTqif1J3MqaeNitJnd8Y0EG80JakOz/R8tGM4+F7obbWMgEen8ut
         Eu8aoXsNA0UHcd9L6oZCLAWotZu/4fsIO5XkuJgl7S2FAar/rfpFjLflmaH4RkYbIBP7
         MBYhsGkEgCQ/xbudtiJK3l6XwpRNavyO26m0VMbCyGScMPHiA0k45vbRWiYFZHyV+zeW
         fhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783955969; x=1784560769;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FG71CBoheueQ+381OlVy9pD30LVk3nyO1mhdOYTqr5E=;
        b=jkLg4WlMcakKsdtsKV5X3+S/dn67LxyAJEgHsJpaheT3TPyJGm7KpvxDFGmWyn829Z
         v5l4Nd+PEvt464fzW3DgHwsK9HLn6/Px5iqoN6C4YIMeQMbLn858evuvhpIXi3b5fDLb
         0oOhaOwRKw7J5nMoT/vOlY0zxldcjGFN8+4lsApLo9Fe/Tbio4ciuEeNUELpycjaO0sX
         JAFMftULmHtFaVamNMDdOHw+6NDu3S9FIdBuC9i1MQjKdyQs421KEeEE+RWexnAw0Mga
         jNaAGmtsXhlwbeQpaZIhAgBp0otpmOBNvqI+a2zIeWQ4TewBN51TRZUM9Ecs3cMrJkTR
         w58Q==
X-Forwarded-Encrypted: i=1; AHgh+RpbxynR97nkDqVmsKlxgIVB++T4KL083NmXURlHgQb4SB7g22j8px/dX2QnvyK5niNaEZR8WIHOHFU=@lists.linux.dev
X-Gm-Message-State: AOJu0YwVGVJ4yc5XyJGpalg0ZIzYrhkcTvvLlb2TjmTLYtaEAMbsUq3v
	905l4Jr3ZQ213qZC/iHoZgxCh8Uc5YFGTsf5o4DdtduZXBGqvuUbxcWPhvAlYlL0AAdKCHrd9xE
	kT2F9eBgvsAU3OyPHwwvMQ93j9ScxZ8DZtk4HT1Uc
X-Gm-Gg: AfdE7ckjcsKVbXglNVeu1YrM2vqxadsRReX3QaQYmrPg+rnmyv5zsMZOH+cvnlWGfns
	6Sw2nQuknwsH7e7Cy2hIt3cCBp2aZIBDKwApwwzN1bV9ZpmY83uRm4O+M3cDicVnQcD2h44Lmvw
	H9nxteJDH2e/VsTFuqtBl+hUibSLXJ0LQLdpuLFsA1maIhiUJHxu4naXFRG2sr7SklJWm5Vq+CC
	/qJLeB6xkT0SG5lUWmvrdISehaGukzGmAjw3Th/pQqS/zedLhj6MYEsKpoqluoxE8XicS8=
X-Received: by 2002:a05:6402:5612:b0:697:be5e:3c26 with SMTP id
 4fb4d7f45d1cf-69ccf0e109dmr30478a12.7.1783955968197; Mon, 13 Jul 2026
 08:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260712174619.3553231-1-tj@kernel.org> <20260712174619.3553231-2-tj@kernel.org>
 <alTsERFTlUKCLw4C@matt-Precision-5490>
In-Reply-To: <alTsERFTlUKCLw4C@matt-Precision-5490>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 13 Jul 2026 08:19:12 -0700
X-Gm-Features: AUfX_mwJphU_f7-jLqu_Z_Ua6JyGkcwumDuVDobQYNKxyxoqyxOYbk8wQ-qoTzY
Message-ID: <CAJuCfpGAx3t_ur3gkpvr8uxooM5=1pbA+ap_qtUvu=CjNzaYzQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/psi: Create the psimon kthread outside of cgroup_mutex
To: Matt Fleming <matt@readmodwrite.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Peter Zijlstra <peterz@infradead.org>, Edward Adam Davis <eadavis@qq.com>, 
	Chen Ridong <chenridong@huaweicloud.com>, Zhaoyang Huang <zhaoyang.huang@unisoc.com>, 
	"ziwei . dai" <ziwei.dai@unisoc.com>, "ke . wang" <ke.wang@unisoc.com>, 
	Matt Fleming <mfleming@cloudflare.com>, sched-ext@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 6:48=E2=80=AFAM Matt Fleming <matt@readmodwrite.com=
> wrote:
>
> On Sun, Jul 12, 2026 at 07:46:18AM -1000, Tejun Heo wrote:
> > a5b98009f16d ("sched/psi: fix race between file release and pressure wr=
ite")
> > made pressure_write() hold cgroup_mutex across psi_trigger_create(), wh=
ich
> > forks the psimon kthread for the first rtpoll trigger. As kthread creat=
ion
> > depends on the whole fork path, the commit inadvertently created a lot =
of
> > unwanted locking dependencies from cgroup_mutex.
> >
> > sched_ext got hit by one: its enable path blocks forks and then grabs
> > cgroup_mutex, so a pressure write racing a scheduler enable deadlocks, =
with
> > every other fork piling up behind.
> >
> > Fix it by splitting trigger creation so that the worker is forked with
> > cgroup_mutex dropped and the kernfs active reference left broken. The l=
atter
> > matters because rmdir and cgroup.pressure writes drain active reference=
s
> > under cgroup_mutex. Publishing the trigger last keeps error reporting
> > synchronous and preserves the of->priv lifetime rules.
> >
> > The trigger registered in the first stage pins the group's rtpoll machi=
nery
> > across the unlocked window, leaving only creation races to resolve. The
> > catch-up poll on installation covers scheduling attempts dropped while =
there
> > was no worker.
> >
> > v2: Retagged sched/psi (was cgroup).
> >
> > Fixes: a5b98009f16d ("sched/psi: fix race between file release and pres=
sure write")
> > Cc: stable@vger.kernel.org
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Edward Adam Davis <eadavis@qq.com>
> > Cc: Chen Ridong <chenridong@huaweicloud.com>
> > Reported-by: Matt Fleming <mfleming@cloudflare.com>
> > Closes: https://lore.kernel.org/all/20260710100441.2653477-1-matt@readm=
odwrite.com/
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > ---
> >  include/linux/psi.h    |  4 ++-
> >  kernel/cgroup/cgroup.c | 23 +++++++++++++-
> >  kernel/sched/psi.c     | 69 ++++++++++++++++++++++++++++++++----------
> >  3 files changed, 78 insertions(+), 18 deletions(-)
>
> Tested-by: Matt Fleming <mfleming@cloudflare.com>

Acked-by: Suren Baghdasaryan <surenb@google.com>
