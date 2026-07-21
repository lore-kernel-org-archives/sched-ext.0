Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5815F2E11D2
	for <sched-ext@lists.linux.dev>; Tue, 21 Jul 2026 03:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784605201; cv=pass; b=GtyD8JWZi9V+WhXBWS4gwKUgiRi05gZgQAV9xYK2ss+SjcWmKhRAlKz0FCJC4ldPDWSuujVlIiZ8tCK777NVBamxBz0Mcuv5dSkctDK2gi6IVasuAunMX5xxPuxEbrrRY+4whdJxEu4At/6GRmteRcc6kNs62kVKdwec0Tu8ubM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784605201; c=relaxed/simple;
	bh=XgD54F1DtD1Vj6jOqt4ULyYxQ7RRwPT1ZS3xtUCoBKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YL+20XH+T0yWASK9yanund2Fjs1zJTfVVhO3KQhX5y8sih/4DiN0LyDBqTMFnQPRgYyalloMTgXdY4/9VpA/DoEIhaIjh2R8dhYU4husugkYQ/YIDWv4SYtm1sMVRXcoVri5mlC5As06dsEqscR+XFSeG8CnlhwEw5msq45vVFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ONR/A6sh; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ONR/A6sh"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-384c94c9414so6299141a91.3
        for <sched-ext@lists.linux.dev>; Mon, 20 Jul 2026 20:40:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784605200; cv=none;
        d=google.com; s=arc-20260327;
        b=bEYOkppN4tPnpGNVPDyT8fqKGUWV3gIR5HMXBq6aihL6w6t66ZS7+EccUE3wvlo3wk
         vE5XalQvLmR/4bhakZbjtcALor/FyNHD8RC2ItB06+BwJcWbo6W5166kj8NxJsSVa8DU
         iIcIsSgGBdIpVE0RFDt4jGIutVt25CCGaOjsz+bblTCrNy+0fEwXLhN1ZEK2iaw0SCcg
         qP3kWSaTm928S82bpu9EY9LfQXDav0htF0/hBJGqwy/7Lp/6YZruAnmDI/RXYOB2h1wK
         O+jSZq++4XrnER4JPJIkb9FbCaaJFBstTzGyKxm8aL/pWTpkqD1q8jd4XAbIYiLT24BV
         PbMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bm9+CkMbHVpWNFHd9a6kLDGKQZHPFet8Jy8MbQJXmio=;
        fh=rTEp8C/kAvFOL2ISv4NwyvI5OlYCp8iH8yFYZf5S9DI=;
        b=eKFaK/xff5sRr9sCPIARLPVSgOckymtxL5UWX25EasYce0hpT3BOF01ztOS0EebRLm
         dB7Dfs9DKmeJtYg3HTL05AfyQ8D9K//te3fNsKwH3j7cVcHcTEcKErR7dVkfR1/tYrOx
         czKFZOElUbdUCvTwuN0/gVk/tR2iYdmZQ+TlhOQOK04n8kUWBYqyTfyIiNCn5M1ttRxc
         zK6hOH/dhchAw12G6SkbCxKC7sQfHZw3Rwpo279DbljMt6akja6Lvq95cMmKOEHUClss
         XogXx2ZjL4nL6DQd0balzEuTytbhu2CqaE1a2fcdR9y5hvC7TeOI+bYGQ5NhwIYvMTzc
         cMuA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784605200; x=1785210000; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bm9+CkMbHVpWNFHd9a6kLDGKQZHPFet8Jy8MbQJXmio=;
        b=ONR/A6shkh7lSWxDd/yHzgeTIzB8T8dtocYnL6nf7MN2tw/wilN9DlVJ54xbJ1ZWKL
         UjTlh+RTcdOsVWkhPvifyxIwbgJynL1xej2CPXNat49Dmn7skiTjTtO7NRq8lWidsfZk
         TJ2DBuMgLjTfYPfIszc4sTItck+2Bhm/f/kWRONkMOqe203SfdzQjziigvPhLz+7z3X1
         NNniTvQZcDtAI5bASDk3zNoH4qO0CWl7k9Kb9FzpUi4cy0MkXhs19cwlk9w+stPtw5CW
         fUZ89fRlICcsHBsXsEbLSbrK79VvXtox212WKEnDGvkGcVZZ0988fx0UnDDtTfpFehTj
         tZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784605200; x=1785210000;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bm9+CkMbHVpWNFHd9a6kLDGKQZHPFet8Jy8MbQJXmio=;
        b=sQc5GkBmNWi6PDX+goTqWxgPqlgOWmT4qgB/83H96P9VebaK1b5kO91InTGn5/H4BX
         D1Y2W/CKL9T1BKE9DEZEhyZeoaiB1LkirkN8d+PwTBiVA1gHdiNvmNXKaezUKRky4TyY
         XmiaTHiNfyVGzNhKzxBR9mNMdiVtE2v6S5MI95xt2le1bcpfQb7QSHvC7fbE942yC5EQ
         1X9rq2L68J4bWuFjU3m0Qxgoqn9aL3PO8URI69hdV2bvPO9w6vdDWETK46HPuU/Iuum9
         7jFvmiJTZ989507jy+EAk7WHUEj5rvAhJhDbUgnl2MnEFDPKoCTixk7t3zT7hFfJMgmy
         4IEg==
X-Forwarded-Encrypted: i=1; AHgh+RpcP1lhoZNgg68tDwH752PzDMn3hq2KAo3d+LzWbmtqNGY6S1oBCWPqHESCk6SJXzdBeJcoRFPyBwo=@lists.linux.dev
X-Gm-Message-State: AOJu0YwqREnWA5Sg2sME8XoCqtsB+0q/KUaTg75my7MuM9Wuju4fvNri
	Vc5pQUutCHtb1qHkbkR+iq+302TowmNiFx/2RuSOAGZCq9JQw8vO6JV7exTCf8H0OQ7ENsd1z/3
	SJvpYDfLmrQgO01jVKEIDRCz/V+ZFG/AWNKhoQek=
X-Gm-Gg: AR+sD13hI977hL7nmp8xbKp83xXH3zpCMmLbGO4kf23oNxGooFA7bbVfc9lNuZT9W6S
	Vv+5401Nc/nxzMytmMsliBOxsePb6ZAx4/36TEBNLTlGQrGFdtV/FNu88TsV5B9y4mnirRAAZVC
	/vdr7zj3nXKSylGN8285odxu1npMfNtJLOOAr7XhasqAQOwO0ake23ahuKEd+wezpaQNJH0b6ZR
	g9QyLVZcVocWjWFre/0ZAC0zoPZijSD6HxsD/994ZwN3c92IEfkcaqjVgt8+6aJ5f9yV+V+jukp
	uPwnunEfRW02WCm35FNe+GEzgAhGySWgflqwPdIcPVjJw/LjuAKLgB33NWbKe36XrGmkXCTI6AN
	QV+bp4Rz9Slzc
X-Received: by 2002:a17:90b:6cb:b0:37e:2005:6507 with SMTP id
 98e67ed59e1d1-38e4b42355dmr17545275a91.15.1784605199252; Mon, 20 Jul 2026
 20:39:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260716132229.61603-1-arighi@nvidia.com> <20260716132229.61603-11-arighi@nvidia.com>
 <CANDhNCoaZnQXeFcxAv4XA4dW9sq9k+nm+0=EcqmLDvhMqKPdnw@mail.gmail.com>
 <alsTZ3oBDndrw52u@gpd4> <CANDhNCqSSf9UPzo_6Z+giTJHRWC6X=D=daWuzbLWyDYsFbZ2qA@mail.gmail.com>
 <als4NSM0zWyhAgEf@gpd4>
In-Reply-To: <als4NSM0zWyhAgEf@gpd4>
From: John Stultz <jstultz@google.com>
Date: Mon, 20 Jul 2026 20:39:47 -0700
X-Gm-Features: AUfX_mwE3rXCWQXFH1-MBAJ8gQG1y-17oD8ehiFDZc7PVpFrpAxZZovYfNHwRLI
Message-ID: <CANDhNCrg=_xiyga+JoOJp16+Omz589bdBsHYKufJpnf4K1pbLA@mail.gmail.com>
Subject: Re: [PATCH 10/11] sched_ext: scx_qmap: Add proxy execution support
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Christian Loehle <christian.loehle@arm.com>, David Dai <david.dai@linux.dev>, 
	Koba Ko <kobak@nvidia.com>, Aiqun Yu <aiqun.yu@oss.qualcomm.com>, 
	Shuah Khan <shuah@kernel.org>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 18, 2026 at 1:24=E2=80=AFAM Andrea Righi <arighi@nvidia.com> wr=
ote:
> On Fri, Jul 17, 2026 at 11:04:16PM -0700, John Stultz wrote:
> > On Fri, Jul 17, 2026 at 10:47=E2=80=AFPM Andrea Righi <arighi@nvidia.co=
m> wrote:
> > > This looks like something related to BPF arena pointers and incorrect=
ly
> > > generated BPF code (the other schedulers don't use BPF arenas, so tha=
t'd explain
> > > why you only see this with scx_qmap).
> > >
> > > Which version of clang are you using?
> >
> > Debian clang version 19.1.7 (3+b1)
> >
> > Running in a debian 13 vm.   Though I'm using gcc normally for my
> > builds (but I see the tools/sched_ext/ build does use clang explicitly
> > for some things).
>
> Yeah, we explicitly use clang to build BPF code. I'm on CachyOS, which sh=
ips
> clang 22.1.8. In theory clang-19 should be enough... if you can mess up t=
he VM
> maybe give it a try with clang 20? From the dump it really looks like the
> compiler failed to generate proper BPF code for arenas.

Looks like you're right. Using a 23.0.0git checkout it seems like its
working better there.

Thanks for walking me through this :)
-john
