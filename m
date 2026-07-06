Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832A13E2759;
	Mon,  6 Jul 2026 22:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783376097; cv=none; b=pHCddBKiOXWxOtgKbqQBtZpwgQtVj796ob9zw6z+8ttgPbHUQo15vWfgF5Mj+9yiL0GI4zyEEl0fV4XSaqkB0GCGqsVIvlr8hfOk6F8ELKi6GrXhsyMPRi6gwxUSpsp/8SetBfhhI9h5+g4N0RFeJQt5Vd9r1CQtX1xteg+R8LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783376097; c=relaxed/simple;
	bh=6Jni+qdKchefKu/CWJJddJmPjL1XvjIiVhdDO1dGt+U=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=CugGZYys37cv+86W1NnOU2CvU8hnArvNBpmERH9sO/bZ7dDZimFx6ZlizfC1OUz+gNyw1jRyJnY/cLpJsF907usG1AyJzIOhpEFi7KyMX/dOCo+spp0hLeg7lhkToAMM5AQJT+pOv41gpZQF7jXp9ksJZPm5Ge3cAY3CDfS59fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jelLn/j7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jelLn/j7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2441F000E9;
	Mon,  6 Jul 2026 22:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783376096;
	bh=MhlCRH7Rcucb36LrKF8yTPXwo6+ISABWIcdAenNXS/g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jelLn/j7Vs+K2aTgAiWW/hzJWjyheT6Jbj9qgqaf56MiRAtZuQYfKpNyp/XGhbiJv
	 SRPf7Fhzk0P+wqpQ765ldqkgC+4ZJIaQ18YFHpwxJEY7V/tmmXf1agxqUbU4fjOjXZ
	 J0vfn6KZ2zO4x56Fr+j4EVbi4O9Fx28ANT1LQA+ItJK3Mm9xEFzpe5dNGSSnaV1MZv
	 YCwv6tVSJt+GDcenETx6GZDjFisdJFGuxHZIMLwMnb/o1FrwoQMqBG97CkMBoCaPKK
	 ND1KZxjE5scaTFQ93lxOzc/H6D5FOxOrCCiELvpL01tYefC8H7HvkIGLgQuDI4Cuam
	 iawmY4rprAG0g==
Date: Mon, 06 Jul 2026 12:14:55 -1000
Message-ID: <9fd7850724a5993f7ef8e151374f72b4@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Arm the exit on the sub-scheduler enable error path
In-Reply-To: <20260703191002.804763-1-devnexen@gmail.com>
References: <20260703191002.804763-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, David.

Thanks, the diagnosis is correct. This is already fixed in the pending
sub-scheduler capability series - the same scx_error() arming at
err_disable is folded into:

  [PATCH v2 sched_ext/for-7.3 19/36] sched_ext: Add per-shard cap delegation for sub-schedulers
  https://lore.kernel.org/r/20260706014058.439853-20-tj@kernel.org

Thanks.

--
tejun
