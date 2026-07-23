Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578C93A59B3;
	Thu, 23 Jul 2026 18:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829924; cv=none; b=g389xdBWH41uQPYguU1yiy1aMEiRxgc+7pDyzysZFXatw32oSVYFf8wxu2JALaoqJSDQXAEDF2eM3JmdE+ODQlCVNT4tVJZoe4ZE5OSSF2lgbaxWdk+nLALrtmgLbCDHz5vfJis125UDX+lW1HIWiIv8wyI1jxKRDzCl6fvoCmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829924; c=relaxed/simple;
	bh=EpFnXoBoLg1IMGp6oO0WLGKYnjydLBOo0Bl1Dg1Wwwk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=qWYwwuFmeoHSJlSaagApoyUGqfAFkK+EODanGg4Oazl2NXNcvwTlcZejphr9fOBYnWwyF2iHyxCWbYWKeMMMhLpTzzcG2FGK1zyBkEi7ut6SH6KvFb6XTw6mKNeudTFrGjnmW801MxLLmeiU4/3lKUuJBUyhT/kHhmK2raEIDVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B518A1F00A3A;
	Thu, 23 Jul 2026 18:05:22 +0000 (UTC)
Date: Thu, 23 Jul 2026 08:04:51 -1000
Message-ID: <35d4377b88422829a7f03300aaf7738a@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 David Vernet <void@manifault.com>,
 linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-7.2-fixes] selftests/sched_ext: Handle
 sleeping task affinity changes in numa test
In-Reply-To: <20260723095955.1415621-1-jpiecuch@google.com>
References: <20260723095955.1415621-1-jpiecuch@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Thu, Jul 23, 2026 at 09:59:55AM +0000, Kuba Piecuch wrote:
> When a sleeping task's affinity is changed, task_cpu(p) can be outside
> of p->cpus_ptr until after select_task_rq() selects a new runqueue for
> the task during wakeup.

Applied to sched_ext/for-7.2-fixes.

Thanks.

--
tejun
