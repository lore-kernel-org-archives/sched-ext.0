Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A837C246781
	for <sched-ext@lists.linux.dev>; Tue, 16 Dec 2025 19:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765912313; cv=none; b=LNQlQm6jwHoX4PQ1F/Fs/YqEfvL1OB842/LAe6iAUUbxWpPGl/5QaXmgNK92AsouBE8RIZ+SqYYQKGOUbsIgXVBkKsTTyrEAJfcXsWHZsZYV7K49zTGTuznK4HLYYgLC2MaZnriUNURSigKyNosqVnWxmLopGFtkA1+ztrljAGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765912313; c=relaxed/simple;
	bh=dk9nIUj9f0VAlNwc3AdYfe/5hjAsS73L0kzIrupELJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgLGpgZ5OQ8m66Y2nw984aWOX2TfhxWqwYncfFDvq3Oe31chDgzk6zB4vLv4eqM8BRvz2gaq51t9umCxetUEA9xHDqsWp+qc8/nqs98iVUHui8wpWFZYs88zMbQz5ovQ4JDR1hQ/T58eXkXM1R95YjpS2fBI6c+UIaaWL79B6Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fzwXfkqG; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fzwXfkqG"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c13771b2cf9so2474523a12.1
        for <sched-ext@lists.linux.dev>; Tue, 16 Dec 2025 11:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765912311; x=1766517111; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bb3lTxowI2Z4M/C9yO9DqgcCZ0NB45Dqo5q3nNgrLGg=;
        b=fzwXfkqG9qu0sx63JMtyQCQPogtfEPT5+mWAgaX7iTcPAx6OX/uHt2pyAEmGODtCmR
         Cex4rgpm34QIpH5f4bljzAI1TbSEBRrRBGUdEt4w4rdc0/1dGW6Bio+NQP76yRDg1VNt
         //Yy/fHtUZd+mUq121zP4pI/bzgUoWoto3kRnctuV9fG7yvcb73EQsQ7RdFOSqmed/6e
         Zc8fNj3RpmpaB5wIOIIG9I9fh9gseMRl0C2J6uYlwCnyo+HlXYM12yJlfXUpVXR4UF+e
         i5nziZBwLvnznWV/JHl+yeyAGvtGoRK8lKax1CIykWWB+GAZTDAHU1B4lVK4Bk5/jpvC
         Pf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765912311; x=1766517111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bb3lTxowI2Z4M/C9yO9DqgcCZ0NB45Dqo5q3nNgrLGg=;
        b=KBjEMg1DQ3iPPfUq4H0NIji6W8LPNKq6HGzjSy8a0gbT9mtsTBVwyAyzWomKoQ1i2K
         KQW6mRGbB8d8Y5z7pngx/UB6i1TZtAcK2SFbLGW+oYOTTmEMk2nKVjrv7ztPqJVhCFqA
         T0iovuUryLKDG+g1Sf0A5ZRAQqeHCExdT8AwgHc1DeePVgloCCPnk1ovz4VuGmXvV2Qb
         qI9xf88U+pZfninqdWH2BNoopLLPhBdhYl+hyIbhFgA397QG3YmA5M4JPIFdDToYDac1
         krfHsll8CSbl1P7vzHZOwbemTjAz8REbzoCOqHciXuz+LluXYz0K4H9ASYBdyzI4E+Yq
         6ZIg==
X-Gm-Message-State: AOJu0YzwrFFcgACjEgTOcnNOb9+HENVEuId+vMbEd7/gn1+kl9YVmZuV
	eoaFdYaoqmOl6doeq2K3vKuswQBPorslF3C8yhsP94fYbjTFd+O+lH32yNoJehvm7kb7iZIPtcv
	glbsrpoLrnT1oS7scUJ0LeQhPrCfhT+j0NY9KM/R+5Q==
X-Gm-Gg: AY/fxX5YP1SoS3MnJ/mZhPK9UP7mBnrCHRQ4s6Nbs687+VLIrIMR0bwQ7a7zaEoNpvD
	JtZ/2VktMZStqIdXUBFwxpaq3Kfx9NsMEFljxB/+52PJM44Z4fQX6vpJJatTkDIbNC5vlCsafat
	9zvoe9vUlJT8A1A4qJJY3+2OIp/J4IbwFBddLXLR6V+wgxIlE89FjaBOEZbOaQIGz8H0kfG6AMQ
	cTZVUXr3IgD6kA/FZfwbaasGXCuFPTGzf0tGa6noBVBJ1skqTgEfAHDjE8vwyxQ1hyVPCs26mlE
	+zdTC/f3LtQi4gGUXEUv/e2TXMUx
X-Google-Smtp-Source: AGHT+IGMhvPi1jDJcszt8jA4a9heBaNGmNdHt4wN24Fq3bkSPPKueV6lVmf1z9L5X3d4gEs3hU8IBylqrPJR8yw99Qo=
X-Received: by 2002:a05:7300:d409:b0:2a4:3593:c7d1 with SMTP id
 5a478bee46e88-2ac2f8b1e69mr8592833eec.17.1765912310774; Tue, 16 Dec 2025
 11:11:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+G9fYuphjUO2x6qP2qPBFGSYz2WPp8fdGdiNGtyd1PmEVJrmQ@mail.gmail.com>
 <aUGVACX9sd4IUR9k@J2N7QTR9R3>
In-Reply-To: <aUGVACX9sd4IUR9k@J2N7QTR9R3>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 17 Dec 2025 00:41:39 +0530
X-Gm-Features: AQt7F2ozGJ4-fw_vl1t73Hct0jcGvkEtNTAQ8xWVgn3wVknKGZQK6qiBkNQmZEg
Message-ID: <CA+G9fYv-h1ONWq232S0BxpdWy52ysPs1VPzKV6ZypSV6B_VSpQ@mail.gmail.com>
Subject: Re: Boot regression: arm64: WARNING: kernel/sched/core.c:10851 at sched_change_end
To: Mark Rutland <mark.rutland@arm.com>
Cc: sched-ext@lists.linux.dev, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Tue, 16 Dec 2025 at 22:53, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Dec 16, 2025 at 05:09:52PM +0530, Naresh Kamboju wrote:
> > The following boot warning is noticed on qemu-arm64 devices booting
> > Linux next-20251215 on wards.
>
> I didn't realise LKFT was operating from a hospital!

:) No hospital ward involved :)  =E2=80=9Conwards=E2=80=9D it is. Thanks fo=
r spotting that.

Thank you for taking the time to review the report and for the detailed
feedback. I appreciate you pointing out the issues with ordering,
formatting, and accuracy. This is very helpful.

> > Regression Analysis:
> > - New regression? yes
> > - Reproducibility? yes
> >
> > First seen on next-20251215
> > Bad:  next-20251215 and next-20251216
> > Good: next-20251212
> >
> > Boot regression: arm64: WARNING: kernel/sched/core.c:10851 at sched_cha=
nge_end
>
> This email is really painful to read, because the information is
> out-of-order and has random words added to obscure relevant information.

This one=E2=80=99s on me. I used Gmail instead of git send-email/mutt for t=
he
kernel logs.
I=E2=80=99ll use git send-email or mutt for regression reporting going forw=
ard.

> The warning you quote should be the *FIRST* line after you mention "The
> following boot warning".
>
> That should be quoted *exactly* as the kernel logged it, without being
> prefixed by "Boot regression: arm64:", which the kernel didn't log, and
> which is redundant given the title and surrounding context.

The additional prefixes were introduced for internal statistics
tracking and report classification purposes. However, I acknowledge
that they reduced clarity in this case.

For example,
Build regression:
Boot regression:
Test regression:

Any suggestions for a regression classification identifier for reporting ?

>
> It'd be *significantly* clearer to have:
>
> | I'm seeing the following warning consistently on qemu-arm64 when
> | booting next-20251215 and later:
> |
> |   WARNING: kernel/sched/core.c:10851 at sched_change_end
> |
> | Note: full splat at the end of this mail.
> |
> | First seen on next-20251215
> | Bad:  next-20251215 and next-20251216
> | Good: next-20251212
> |
> | This looks to be a regression.

Noted.

>
> ... where someone can see all the relevant details at a glance.
>
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

<trim>

> This is all formatted illegibly since it was line-wrapped, and you
> didn't mention why you're dumping this. AFAICT the only relevant bit is
> that the warning is from:
>
>         WARN_ON_ONCE(sched_class_above(ctx->class, p->sched_class) &&
>                      !test_tsk_need_resched(p));
>
> ... which Peter added in commit:
>
>   47efe2ddccb1f ("sched/core: Add assertions to QUEUE_CLASS")
>
> Have you tried looking around that commit, or bisecting?

My point was simply to share the git blame details for the recent change.

>
> [...]
>
> Note: I've fixed the line-wrapping for the below. Please fix that in
> future.

I=E2=80=99ll make sure to follow your suggested regression reporting format
going forward.

>
> > [   14.696414] ------------[ cut here ]------------
> > [   14.696418] WARNING: kernel/sched/core.c:10851 at sched_change_end+0=
x168/0x188, CPU#12: ktimers/12/117
> > [   14.729321] Modules linked in: cppc_cpufreq(+) arm_dsu_pmu(+) fuse d=
rm backlight
> > [   14.736718] CPU: 12 UID: 0 PID: 117 Comm: ktimers/12 Not tainted 6.1=
9.0-rc1-next-20251216 #1 PREEMPT_RT
> > [   14.746190] Hardware name: WIWYNN Mt.Jade Server System B81.030Z1.00=
10/Mt.Jade Motherboard, BIOS 2.10.20250506-1P (SCP: 2.10.20250506) 2025/05/=
06
>
> This doesn't look like a "qemu-arm64 device" to me. Are you *sure* this
> wasn't bare-metal on a "WIWYNN Mt.Jade Server System"?
>
> If not, why is QEMU passing that gunk to the guest!?

Apologies for the confusion regarding the platform identification.
This warning was reproduced on both qemu-arm64 and Mt. Jade.
The log is from the Mt. Jade system.

>
> Mark.

- Naresh
