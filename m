Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D89281376;
	Mon,  8 Dec 2025 18:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765218223; cv=none; b=d5oCyCGcUW8RI3QA1/zodEIIjzI5nwx8JZ5uLZiQSJPT/w71v9ccEqwuVz/UKP5CbXUfGtuSqz/KXQe77L11aftD5a4NVYLLcYVcRj0yz0EPJon1FYXH+yk9wsbdH6rS+SWT7tQn314m+O3QkuIJmLZ4XxIXoiIz4HVc8PQKV7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765218223; c=relaxed/simple;
	bh=NfNamV85A6gOn/SvQS+YIqVsTtR8U4k4zlCh6PFdbOk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=OixZad72S5Azi4IG+Chn/bidp13TWXcKT9Ggpz5VHJxIcuPX95Iq2rYjsPxG2olJm3a8iN5TdFG0WAMbJF+bRMs+VEVtmJ9hsMvHleHUk97BLvyMqZz90K+4FfFqoGFr0EENqQL9DhM8dT9BagOV7bQsSFl3KCbruP8y4wwWKP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOrIWHOG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOrIWHOG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2253CC4CEF1;
	Mon,  8 Dec 2025 18:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765218223;
	bh=NfNamV85A6gOn/SvQS+YIqVsTtR8U4k4zlCh6PFdbOk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FOrIWHOGUC6ejF9ifnsI9CSHkZ/T3m2F69Xy9OT65Ob6rRrtI28VoIPGDTbS/jGet
	 6hioayMBQlBVfG6aiJUNnEGTc1xQbGMzpTl+pYg1MfT1bA3/qIGbHrkdqUrlfNzJCc
	 qrsbPA23JjuGn1VtWkj7D5Qq6cgHMD2u/EhaYvNi7LkZHhMI33NW/A3MglTnhwwXI+
	 JzwPuoF2V676dkhNdMJoCPR34uVbEov14sAv0NCE56s6X9QOYdl3Dr9S1g2T82lo/s
	 iERCeIQJFEj0dLSy0LjEuCqFyuS2F5wX3Lo5Qjd7g7KJ+oF87iiHlQw7UVI8xTHCpY
	 SAZCYQGx4maig==
Date: Mon, 08 Dec 2025 08:23:42 -1000
Message-ID: <27372221f161f90a698311662db55d9d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Qais Yousef <qyousef@layalina.io>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, Paul E. McKenney <paulmck@kernel.org>,
 Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Suleiman Souhlal <suleiman@google.com>,
 kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>,
 David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
 kernel-team@android.com
Subject: Re: [RFC][PATCH] sched/ext: Avoid null ptr traversal when
 ->put_prev_task() is called with NULL next
In-Reply-To: <20251206022218.1541878-1-jstultz@google.com>
References: <20251206022218.1541878-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-6.19-fixes with a note.

Thanks.

--
tejun
