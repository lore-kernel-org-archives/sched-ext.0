Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27E029B216
	for <sched-ext@lists.linux.dev>; Wed, 14 Oct 2026 18:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792002584; cv=none; b=TXCWcrPOxbYHHNYLMeXXeZLZMQMczZ1CYDoe8h/a1vaY/MWOT4T17eeAEuTD9x8n98G35ftU0f2VsekzFwK76/dRO4JuDsHE1CJ/o7qNRK6KqHEzgO8uJwsB3lBWx2TVmiRr5PyHypDIneDzbYePHZOGzSpihaheCsh5teTlpYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792002584; c=relaxed/simple;
	bh=8QQXFtXTOo1xqtlgJkiI1JbVY8WjSIr+N9dNMgGzJbg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=TjfyPL8LoLDwVzRHFV9gfG2g89a3bx6VgL4ArNPvpm/Je6/z+/3Sq09zm/bOAyZfqjHfujmuqtu+hAzzWaaOb5dZ75RKgoZvho8vQK5wCUeWIoaSOcNZ4B1+ei+N3b66D6rk0VI26PyaQOZDo9rbOmhYPGKlQgHv5M9guZ448iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFQfzpEo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFQfzpEo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0FE1F000C5;
	Wed, 14 Oct 2026 18:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792002583;
	bh=p0K9npiZqji/bubRznJUd3wI75XzNHMhuY5H384wuVo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hFQfzpEox4AMJMTeg3CsZYiymN157hqCdWP2bUbhWbNi4rWsrgFDrLSwhCkriE/u7
	 8AJqfvI3VNE7wejzNpiz6acisd51swla8kE2OBbHCx9HYv1Mqj+f1R4oCcCpwTT+DE
	 ZYAzzLjg02yZmX1vJx4WBewfRs4h9LLiRxjplLd0/crZr22dGT3zzu4qZWC3o/C7Fz
	 02pjKkrnITiqmgY2Qwk8E/E9foClPlD/wyWGeu4EKA4kTIyiOMoxLxNGLxKxm5HYiN
	 wWrNK1qUC+SOyYpMcloAFyx7OrSYeLj8bmpmJI2e/lNNuyH29mu9P6ki942UQqppSs
	 Cm+OZMvQ7wjVw==
Date: Wed, 14 Oct 2026 08:29:42 -1000
Message-ID: <b1ddbe8d5629aca83b245af25694ea25@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH v2 0/6] sched_ext: selftest infrastructure fixes
In-Reply-To: <20261014131325.793640-1-cui.tao@linux.dev>
References: <20261014131325.793640-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> Tao Cui (6):
>   selftests/sched_ext: Fix reload_loop error-path use-after-free
>   sched_ext: Add SCX_ECODE_RSN_CGROUP_OFFLINE to user_exit_info.h
>   selftests/sched_ext: Fail loudly when EXIT_KIND is missing from BTF
>   selftests/sched_ext: Add SCX_ASSERT_ALIVE and adopt it
>   selftests/sched_ext: Bound exit waits
>   selftests/sched_ext: Report reload_loop attach failures

Applied 1-6 to sched_ext/for-7.4 with description wording fixed up in
patches 2, 3 and 6.

Thanks.

-- 
tejun
