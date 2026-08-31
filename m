Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3251538F642;
	Mon, 31 Aug 2026 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788195206; cv=none; b=SgUGwE94Mi9BdwwdC9nMOfGqHz7sI6BM8RXs58TA7rrkjSSlW57uhBuDVYVwpolKRQl/I6mOEg2FDzWzVCVyzRfnZrrPfkUqzw2D1qwGexBh6mmrpJUYS5uM+tMGH7/6xnBQWw489fwid5egBxU6+ztIteOzW4HRrUttZOuSy6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788195206; c=relaxed/simple;
	bh=HU8Y+49TTsilUCIsPSkf+Q2Xk0ayQqqB4xRNZ967d/c=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=qSCpP/3zAWh/k3GVhzuICWgcSFtAQmnzc5Fi0bhl/AMRULlajrgzcq5PM/e8myPXDwCaFSQHMYBxGOtFre6g/+gZq3K/pmB8DL5VDbI/hwk5hB4qAU6GEcbsRD4wT24Fwnk/frbrmb7cJ7UinRFbnxQ1kO38Gs+TyijM9/nKWgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQq25/aq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQq25/aq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2AEC1F000E9;
	Mon, 31 Aug 2026 16:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788195204;
	bh=gD3dghAhPYx9yCoLaCVO2dtpkXPMjMMYQS8W8xhUJV4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PQq25/aqiYPi5NQuWo/rLmUYmD/2EWzsEvE3ZXOZo1kxSFKpC14b4YEiMJiDfE0kb
	 iAGNQKdZZWNAmABTtdR68LCr8efKd5A1VFJ7bhjzZhDwUQ9n9kjRc4NOr/n0J7Ikdo
	 n2AecIOyAjw+98zeccouTNPthpovNci4ShDUDkZoCOXyH51y6paysl6S/CWd9Ip1YI
	 A0RJWGgMYE8Tqt3aJiGilVGw9f+GCVGe69BVDmfXPdpBRIKiwZdnSzKL/nbJTApNw1
	 7OdtQemuob0bxymPyIriZAi+KCl9pttlQFlwwj747suOFIpQoO3gHaET+9/+jaUHxz
	 7q1JRHz7Cur6A==
Date: Mon, 31 Aug 2026 06:53:24 -1000
Message-ID: <a86be0798945e1b5baba11bdbb10d780@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Wanwu Li <liwanwu@kylinos.cn>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix several comment issues
In-Reply-To: <20260827091411.973621-1-liwanwu@kylinos.cn>
References: <20260827091411.973621-1-liwanwu@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.3-fixes with the first fixed comment block
rewrapped to stay within 80 columns:

-		 * - It's unsafe to use __setscheduler_class() on an init_task to
-		 *   determine the sched_class to use as it won't preserve its
-		 *   idle_sched_class.
+		 * - It's unsafe to use __setscheduler_class() on an init_task
+		 *   to determine the sched_class to use as it won't preserve
+		 *   its idle_sched_class.

Thanks.

--
tejun
