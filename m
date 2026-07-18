Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8E8288D0
	for <sched-ext@lists.linux.dev>; Sat, 18 Jul 2026 06:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784354670; cv=pass; b=fZILgmrMf5zj1GVHp8On84Kn6t78gBWt4UCnaYq/s5WqZQZJV52B69XAFmjwZy60PBd8IjDHyi5I2FnvqgZoT208KUBg8D5yL1xxp1DLTmr1LxKTyMQYY3oUVCGKi9deOXTw+UL2HpT9LEKJxdLDslX9ISM+QX+ZMYSO/j56u78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784354670; c=relaxed/simple;
	bh=Xxs5w1EAIYqabaGxfmk3J3ntYQ5PSCJF63wwPDt3VSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3Wz4nFoZS9XuyV8FukZXVx+0zRvLXGXQCYj50cjElSTsnY+JK1kKWltuBwu74/fGNmvvvKDQS86W6pSuSvRikjtsVHtCFULDwVTpIEpo7bOjaPNtf1mFzBoQvf3sG46XzxsmwlltsmGzX3GfIM9y3Spl3lgY4E0il061bqsleQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H3WFjqtZ; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H3WFjqtZ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cf452def93so3313635ad.1
        for <sched-ext@lists.linux.dev>; Fri, 17 Jul 2026 23:04:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784354668; cv=none;
        d=google.com; s=arc-20260327;
        b=CMVoyNBTYdQtFmA6a9n6Dnc0iA2zGO44eWvvTmWQaM80KlXAR0NE9HdVYyy2afSPKk
         5kHaW14iteJVjjcKBv4L8XmlqvTN+lXaPg0xy22stTYlH6wMbj/gTnB/Dah+oiLBkK8+
         9TnLBhy1ie6lSJtJgKCYZhiGxlFljUwRcwtAPlYiOVN+hwlyY3FAENgj3oZY04NrvuYT
         e4x7ynGrI23mBxum8r5dPco/9W8zv5N9KFObVITGuUhDQ0Y5SoWzCLwTlT2p76aARTYe
         dg/W+1nC+7mir4F8db9i+dFGr/x88nkOrNTE67qZSs1mkOSesspM/3bujxCyZi3WuLnO
         81Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LFGAtQWrhHWfzj+oIbm3LsMLbop1Bl2a2wnxJBflxTg=;
        fh=apiwEEQZNddHHQpsu+P+8PkimrpBe+dNdYhkmMMntQk=;
        b=RooavhS45RXIKJjVWU6vy8yUcDoEKAtS6eIIZ7nfypbDjEaiwoz5+/TeluTdeUUvlc
         vxA3+OjXa/HVW2RwD7w15TTF02aojohs7fbN5v7AK05qr3j94FD6afMdJF3jiJ2aUJWd
         X1dlMBiFGbL+cLjOFIIlbUsZg5alu3uAYAOKUUK12bpGHXS7C5rTUAcCQThl5kRhoDuv
         3/jNeOzQlc5hawriZJPQZVAqZ9S/2kBe7pOKTo8aPZ4RAVqyzynEyuFrDOYn3DVFX3QX
         ryDrje8kTGja7ghgzZvBRMsccJxQmi5H1qlTmwSDvuVIbSal2TTRyXCi/Z6sWmJdBdN5
         XseA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784354668; x=1784959468; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LFGAtQWrhHWfzj+oIbm3LsMLbop1Bl2a2wnxJBflxTg=;
        b=H3WFjqtZ7Bf9sWdJ8ATm75H9BzXxnfxNUET9UA7lTODIbZoF8++sIuOAd4jCIcK6iY
         OVRag0GTIQBl9Xc8W7PGX54xoO3LzvqVvdSO9WhirkAxzYTLKiGehfXtAS++lhk6Kc5b
         RrsZmUCfEYUyakBNvDI1CSmHe7yHEbFM+j0Y+VJu4f/xOhrMLT4q01XbTlPr/PvKQ9oW
         ovj+P+7xBg/ArP7ScXZuprmx8MU9max4FjVGt8utCNNhXwPqrQohJzU7UwWMTgGabpXk
         Y/FRdyo6NgNrSnh1ZXwoy6USgFCaq9L96AQ3283eIK0gPDFx5PQ8mECwr2V7pYtS8SBh
         If1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784354668; x=1784959468;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LFGAtQWrhHWfzj+oIbm3LsMLbop1Bl2a2wnxJBflxTg=;
        b=KVymwJsNbQpLifEwDYHHJzv8aI9qRBn7zuKTT3VMdZoBgapVZxaMBhdiL4feD0/AsY
         V0j30FhpXA5xroX3PRTiXtL1bGckhULsOdZb+TTOzROmovw5ZA2avFkqWMKlN/hkj6Fx
         HiOiEqnaJAiypR/tfkz9++4CIgGRXRwq5LYWAWof6PJj4e26R2ddZqxg1u8+eUMp3zBD
         8altSczy+DDI/5yC4YcIowJ3gBiraHh62k5ZAzxdjUYGilzdA/WDEHhLnNniX5mLYwSG
         adi4BRpxYfsiKwN+492CagaJYbsS/tiadXqViOJQCAZTEoBhgNwoS7TSuep+XSzNsXt6
         aVKw==
X-Forwarded-Encrypted: i=1; AHgh+RpNKDCeXMljoyLwACJusOZD/ax02ypjHQa+TVUTkXqXS/EXl8OsqQ5B3z9zrNY6hq8r5TteuOKR06U=@lists.linux.dev
X-Gm-Message-State: AOJu0YwhNo1NXedMf/PKXwRGTwTfiMD8VjQwHnQtDG0haQ00tzFbitRa
	s18HZV6WAjuP3rQV28kvs8/x0AyhNu/DR5dcKl+veBvHhMGD7TvwdjjKSf6T38zZHgmxgHXgcoW
	bAzBdHsX8fXG9OCt/7IkjWYVmJspWcrpgr+jHFg8=
X-Gm-Gg: AfdE7ckj5re+vkNUbikKkqQXXq18lHcIksdk/ZdujALfgGwFEVigeHmDev9FMEtPJOj
	hev2FxnXf5hzmRJQLJH4GRmGXa6rX5rocwkTNxHfHaAK8TsjgB4/ISC1PvuFONAywSqDPKPz50N
	Oy/t90NTg11boLnyYBMTSYp813JLsWjbcXd4aCBnrr3X7FVM7F0lQ2s9jl6rJXCfI6u+t0I/BW6
	t1g17iOsA/sxq6TmOTi8bna7G9xKOmiA3yM4owfIzj2kaASrLpLgfNVie2eDLg5DGADvCk3Q6+Z
	Lnb4PbI9axzcRTm1mWHVE0D9y7SKSzEZ/0zVZPAjj5//LBYYlugtbMpibMkPfvdICui/bhd/u0l
	MvqQ6LClgBK7skg==
X-Received: by 2002:a17:90a:ec8b:b0:38d:ec55:7aa7 with SMTP id
 98e67ed59e1d1-38e3d29a193mr11040596a91.19.1784354668117; Fri, 17 Jul 2026
 23:04:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260716132229.61603-1-arighi@nvidia.com> <20260716132229.61603-11-arighi@nvidia.com>
 <CANDhNCoaZnQXeFcxAv4XA4dW9sq9k+nm+0=EcqmLDvhMqKPdnw@mail.gmail.com> <alsTZ3oBDndrw52u@gpd4>
In-Reply-To: <alsTZ3oBDndrw52u@gpd4>
From: John Stultz <jstultz@google.com>
Date: Fri, 17 Jul 2026 23:04:16 -0700
X-Gm-Features: AUfX_mxVCR_kfUIxHPO9mjZAt7Y0nDnaJj2mb33KWJgNhrwi_RPCA2RPZx_mhw4
Message-ID: <CANDhNCqSSf9UPzo_6Z+giTJHRWC6X=D=daWuzbLWyDYsFbZ2qA@mail.gmail.com>
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

On Fri, Jul 17, 2026 at 10:47=E2=80=AFPM Andrea Righi <arighi@nvidia.com> w=
rote:
> This looks like something related to BPF arena pointers and incorrectly
> generated BPF code (the other schedulers don't use BPF arenas, so that'd =
explain
> why you only see this with scx_qmap).
>
> Which version of clang are you using?

Debian clang version 19.1.7 (3+b1)

Running in a debian 13 vm.   Though I'm using gcc normally for my
builds (but I see the tools/sched_ext/ build does use clang explicitly
for some things).

thanks
-john
