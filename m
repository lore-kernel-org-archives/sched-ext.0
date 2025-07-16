Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFD6266580
	for <sched-ext@lists.linux.dev>; Wed, 16 Jul 2025 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682123; cv=none; b=S54c57vZjZ3VIZbPT2sDk43IF/wY7zkgUSOglFpaFHxdTGpEuQBE3qDVq66JQDX37g1VkZsUqBpFeDSLnZpO0bZHhHRUZiJacjKNsdBSmCJN5Fk9xAT3OSjMAElxniR0+/B5/P7CrXKI+UTEHXAZ6qDNrc+LznC8J9Te6ahvl9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682123; c=relaxed/simple;
	bh=RuJ0y6y+QAI9WVzMzX/KikwojyoXGGOl1EPIuSN/pqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eabSS5BRBOjtWr5nRYBXKu6RuDbmSd2Uc9RXGAzQV59f0YmzTJmGSGr1hhu3gglxuKP17gqvMbHeKLzkSFDPv6vKEmSetFH1N9Nhe2vK61NRk5Jy9p9zNp2q7HUb4lBiBRAmYf1APSv9/7G8MGxBB8jrZAnjTo3Lt9QEh4WyhA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60707b740a6so10412368a12.0
        for <sched-ext@lists.linux.dev>; Wed, 16 Jul 2025 09:08:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752682120; x=1753286920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjhPeDzwKMbLRpiaCQVZDGt0RvE2h5eKhuFW3u9Cc4k=;
        b=uCxws+KNUI33MlP1gsoqBODEHoxrdwjwTqP+T5T0lxwnKb704K93e8qxUMTKoW54+T
         QpNK8PJIFMIcKV0oTY9CHU6n8viiLt0xdzQQPoXyOYhuTede5HO9kdik8sJUzZhS9F89
         /BhnFYhNY2EETJpy2iS42DM9qNbhhS3QMeWvja6wpxslIAOnIWPzbCfWkooeggWJbgCo
         9HbATeqPPSieh7gPS+6SoqklzFhymMfGTb5vf5IF6pn3ltTYYBkjDSwLm6UxsAX81iyR
         A5YtxMiiNpdJ33t+Cmf55qKQaDBxMTUM85WdoAjzUGBKvTeOlCA1xu9cHOzj0jJbEsE0
         7nYA==
X-Forwarded-Encrypted: i=1; AJvYcCVOLgILTG/PCV+t2x/FoxeHzXXaEl4kBoPtL+OaSOKDhzrxHqTdkPBUmjmMqIj3lrlXYskzFChMIFA=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8c4Oi+TkthQaHmxPfzG5mrfptYBUVgykP40FXLk2KFvSlwMmz
	a3WXMtXcb59JMWlmzv3gD/WgEfU7QdbW82LzXqv1gcarJmkddONBpHbx
X-Gm-Gg: ASbGncuwP+oAJMAB/UgoHNFgR7dDdJ9aVuhqPh7vaAFgEzNzREhVe4AJ5HhTZVC5DGt
	ssI/7e+B9i4P6As/eXT/X+FADe1yfJghG5ojJ8RbRW6fDHn3BPc1V4ekUrwZ2Lgks44Pi+IADtz
	9GIhsXXmYgw19z31a/HW0iJZ0edE259o/gtN5mEXa1kDeHLUrf/ftZu7THZXRPLvk1vMqnbrVRx
	y5gpO/6Lvn2sCUKGoxIGw9kayuueX+HV/ipICWzoeMNbmss+i+C6Hke3Qnz+QdMJlN4N150wjf/
	6N1+bUsNtNNA//hNLXm2lBxq5+yMr91au8RXGvpKXlP6S10JxMB1CEbBt7B2z5/t+0Mtw+B1ikP
	6gML/LSMayHiK
X-Google-Smtp-Source: AGHT+IFnkeUOGi9pD7dry62krv8SIZuFe1pRe8oR5Vur8GS5Ex8kCG5MXl5cty9UiHysD9gduqJFnA==
X-Received: by 2002:a05:6402:34c3:b0:60c:40bd:8843 with SMTP id 4fb4d7f45d1cf-612859338a2mr2877101a12.11.1752682119791;
        Wed, 16 Jul 2025 09:08:39 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c976ecb6sm8848523a12.56.2025.07.16.09.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 09:08:39 -0700 (PDT)
Date: Wed, 16 Jul 2025 09:08:36 -0700
From: Breno Leitao <leitao@debian.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, jake@hillion.co.uk
Subject: Re: [PATCH] sched/ext: Suppress warning in __this_cpu_write() by
 disabling preemption
Message-ID: <imrfubmkw3a6qdznnpounrnen5ituzchwtbjmouocuk77upn67@ljrz32ppyqyr>
References: <20250716-scx_warning-v1-1-0e814f78eb8c@debian.org>
 <20250716125128.GX905792@noisy.programming.kicks-ass.net>
 <aHel4LvT_Y5gpYfy@gpd4>
 <20250716133631.GZ905792@noisy.programming.kicks-ass.net>
 <aHe2j6pIyQiBf1S_@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHe2j6pIyQiBf1S_@gpd4>

On Wed, Jul 16, 2025 at 04:26:23PM +0200, Andrea Righi wrote:
> On Wed, Jul 16, 2025 at 03:36:31PM +0200, Peter Zijlstra wrote:
> > On Wed, Jul 16, 2025 at 03:15:12PM +0200, Andrea Righi wrote:
> > 
> > > The idea is to track the scx callbacks that are invoked with a rq lock held
> > > and, in those cases, store the locked rq. However, some callbacks may also
> > > be invoked from an unlocked context, where no rq is locked and in this case
> > > rq should be NULL.
> > > 
> > > In the latter case, it's acceptable for preemption to remain enabled, but
> > > we still want to explicitly set locked_rq = NULL. If during the execution
> > > of the callback we jump on another CPU, it'd still be in an unlocked state,
> > > so it's locked_rq is still NULL.
> > 
> > Right; but doing superfluous NULL stores seems pointless. So better to
> > avoid the store entirely, rather than making it more expensive and no
> > less pointless, right?
> 
> Right, we can definitely avoid rewriting NULL.
> The following should do the trick.
> 
> Breno, can you give it a try?

Sure thing. I've tested it and I don't see the warning on my side.

Would you like to me post the patch, probably removing the WARN_ONCE()
as raised by peterz?

Thanks
--breno
