Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B18C85626
	for <sched-ext@lists.linux.dev>; Wed, 16 Jul 2025 13:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752672008; cv=none; b=J/4Ar1vmIXvOzhNVX/hTaXq7yWEioM/3qRW4BD1b2KjUlxVYD3oQFRJld5GNK4Y6Dnju9FZTaE87pqWwEHN9B6NdjX7ejFHBdts+ax8eeOJ+WTEW0V1Y1QCZwcDxHRObfYOovldM693Ejzh5z85w6X+vSIORbL7WCv/wDhK1X5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752672008; c=relaxed/simple;
	bh=dACukwy5e1IqhOkQbEEgrKOgUKHKPKIzoOfLvmNuDO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNUE09clFmooQjowO/UXTrZuiF9trZ229pRMQXMLKVZks5kPOEn7UKWphZtdK+VLtQqiLWnG/O3sJBoZtvPgRynsPVnE8MJX3DBW5izMlqQ2wTUqsnx7mUmN2e1Lf4xA6WyVkVRW+4SUO8QefT2VDBTEyZyLtnlLNgn8bvrZq30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so11007161a12.3
        for <sched-ext@lists.linux.dev>; Wed, 16 Jul 2025 06:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752672005; x=1753276805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dACukwy5e1IqhOkQbEEgrKOgUKHKPKIzoOfLvmNuDO0=;
        b=aOuAS0ne6eNqaAtXTDYfYhSCsbPrST3NxOP1vR/O0wW7s0aQB5q37lnnHU0vzH4uaG
         UcGa7uvKaV61c5g9EBxbhG0rfT6TpdtUEz8szsXE8ZGr2tCGTb4wUvsa2CK1z//uhl1E
         CSzigQaqPJVvGLd4P/KuuMCtfSiOUXwdBRj+daGKw2ld+/1j/LzYq5QIMKJ8jtoH7goZ
         SGF4JUkwyYGwVLcBxml0Rnq5Z/sVPxqp3mP1FqK6lR2clOfEASbabXqAY24MvIsrDtOs
         TE4WJe7oJVnv/PoMz1Oo3kPtaEMScr59ZmIfpg7ZTveLh9cpBuQ9dJlxrpdmuiyF9UGg
         D2hA==
X-Forwarded-Encrypted: i=1; AJvYcCWo1BojyqXjj0j7nMP63glwh1pwn6mhTVo5qOdG7w15cSvW0v0hnbWRwZpeIlxT3byrPdEcN8Dqt2g=@lists.linux.dev
X-Gm-Message-State: AOJu0YzbVZAu6uhu7DYatZaWmArWI8WwJrX1obhBr9pbodPrcSxeH82r
	Icd3RO8Wzk6WwJ96cHwDIl1/B/axJ1BjN91gvGhF8Q5qZmUAsoE1Uq6V
X-Gm-Gg: ASbGnctaopPuyWu4GGv2KfTRcI0y6OYBWs1eqnM+HL7m1fjd8r2dIOscLlA1l0j/GzW
	fjuU4/tVGHVgFkhRvWRl7un6D8x/yxTD2XKa8lmpSZD+b8XZth6FNEyL3Z+7gA4rD145wpbDD/i
	2MZIVWRLlj+7pY57BY5aGi11E1B4lsXK+h9ESLOo69Ye4Ge/r0P2Fpf/uVbU680RYKlnHqBQmGL
	F7JRLn2bfiaLJlfC8qxXMPcjaufTqgnvKoOLPvZpozP8Ls5PhiFxwX9+PQbkYSkKnUySq/UYh55
	3UyT4Ex3fd/2uP5KgMFjZbAdgFvMeGqX0ib5kNPOHIbqyo4Y/s1Tl+dJ/vzCWd8yHbvEiuxWkcl
	//P/sqidgOte9660WInLoGaBH
X-Google-Smtp-Source: AGHT+IEV7flreD6co6LNa/Ga66E039SwJUxLo0b9BC7zArsxmbJYOLWaq/Ncwd0UQVGLdGF5I1E+mQ==
X-Received: by 2002:a05:6402:3187:b0:601:ad95:ca6d with SMTP id 4fb4d7f45d1cf-6128595d9c3mr1968290a12.8.1752672005001;
        Wed, 16 Jul 2025 06:20:05 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611fe587b72sm6807251a12.70.2025.07.16.06.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 06:20:04 -0700 (PDT)
Date: Wed, 16 Jul 2025 06:20:02 -0700
From: Breno Leitao <leitao@debian.org>
To: Andrea Righi <arighi@nvidia.com>, peterz@infradead.org
Cc: Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, jake@hillion.co.uk
Subject: Re: [PATCH] sched/ext: Suppress warning in __this_cpu_write() by
 disabling preemption
Message-ID: <d2ocjfutd6o6euvjhln5tj4sdnmlblgpy2papponnumtu5slcx@tfc6y5webosm>
References: <20250716-scx_warning-v1-1-0e814f78eb8c@debian.org>
 <20250716125128.GX905792@noisy.programming.kicks-ass.net>
 <aHel4LvT_Y5gpYfy@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHel4LvT_Y5gpYfy@gpd4>

Hello Peter,

On Wed, Jul 16, 2025 at 03:15:12PM +0200, Andrea Righi wrote:
> On Wed, Jul 16, 2025 at 02:51:28PM +0200, Peter Zijlstra wrote:
> > Also, I don't seem to have this scx_layered

This is a rust scheduler that could be found at
https://github.com/sched-ext/scx/tree/main/scheds/rust/scx_layered

Thanks for the review,
--breno
