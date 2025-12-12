Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4542E283CB1;
	Fri, 12 Dec 2025 01:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765503906; cv=none; b=YliBQMnTjaZ5QE5S0/Ztl+oYSzn+K7bszHXQeVUgma18SDXeK41uIHUIlt415Qev6CuAC3eltQsWM5ej2H1B45GweMQrOH9wwY9N47UQ1Qgx4Ih3CEkoU50glhtEjvTrl32EeDANurAAph7uNjarzcSfOqzLRmG+0BuYHtPdeDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765503906; c=relaxed/simple;
	bh=Rme1Yd+yBSkREnYv1FYRepLp5BllXAfMmJ5a/NYWGHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dbsekt8Rj6yaTt1oCGBpEQkjNMOY7RnU5ucigdFn7kbzmae41bV5bD7Cd2RYL4OXjvaSuRdWXUSGtDdi2Ztm7c3AP8MRuK3/Pu2ORnMwlyfM7GN3F6H630lr95uK0ajUrrfmHQRBOZvsJbUwFxnaIxJLT1zaOVnuihSUOpgZXxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlEk1mMQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlEk1mMQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C738C4CEF7;
	Fri, 12 Dec 2025 01:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765503905;
	bh=Rme1Yd+yBSkREnYv1FYRepLp5BllXAfMmJ5a/NYWGHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RlEk1mMQBzaWrzFS3lemZFTO1E3JpNlAY2FlJfiINXo2aTkv0sISk6EadP3jyHod8
	 EBsCMgqv9u2tQeHQXHR4oqi7Yybl42wnAnqL2UaYW0bOpoOd6qMmOx6s4H+YD6qjpu
	 IXr1mgVK+sW+d1fnMOZVjeI5AFSq8tLOVfBtVGBiT09KFxZkD/YTWMj2iPFFdON+o0
	 tZCjhkcT766aYyiMuXk3BOP8HRFVZvzdJ2ln4DS7iC5ZMcVn9DniqMNoFo6EAWSmpi
	 2i9j8D21Ta99zIhO6wU1gCuYqUB+7XxIyAmoFBSpTOGqgC93/k8beC4JpycrGy26fU
	 bPIyujeLFIIXg==
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	David Vernet <void@manifault.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	stable@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET v2 sched_ext/for-6.19-fixes] sched_ext: Fix missing post-enqueue handling in move_local_task_to_local_dsq()
Date: Thu, 11 Dec 2025 15:45:02 -1000
Message-ID: <20251212014504.3431169-1-tj@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251211224809.3383633-1-tj@kernel.org>
References: <20251211224809.3383633-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

move_local_task_to_local_dsq() was missing post-enqueue handling which
matters now that scx_bpf_dsq_move() can be called while the CPU is busy.

v2: Updated commit messages and added Cc stable.

v1: http://lkml.kernel.org/r/20251211224809.3383633-1-tj@kernel.org

 0001-sched_ext-Factor-out-local_dsq_post_enq-from-dispatc.patch
 0002-sched_ext-Fix-missing-post-enqueue-handling-in-move_.patch

Based on sched_ext/for-6.19-fixes (9f769637a93f).

diffstat:
 kernel/sched/ext.c | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

--
tejun
