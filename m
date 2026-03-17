Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C68280A21;
	Tue, 17 Mar 2026 17:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770051; cv=none; b=U2dKcJjLGoIxM2kPfRYYMai7wWoP2VraI0IyfjKI7twW73hsM2J3zWgVoqH6M8KnY4iK1yDvDLG2AmM6FyiCtlMP+X4rtoM68QWNo6jJc/xtWawDdV+TLk2vfJtyfOOHeu6SO/lGSu6x5KV4MRkGxs9ur5bu6RejuEwD5W6g28E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770051; c=relaxed/simple;
	bh=o9U4kP9BoiNmczBWmGX/rTwZTTh7SYM3gh/9l0lKK5A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=o36SBtCHeB3+k1UwdT7LKrNAdG9DLlOn+RSGu3cCupss4pAtVRPv6siL71y5ZI6BfLv9ucXv5NTbHn1GShhK+wquCYz+Ew7r+LSe5nx32WcgsOipWmgXDVKFZbZzJIk/aIxPjmospMOhYKA2uF7y9ZZNVGx6rb0VaSYpf0iXtgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YN/ZWP53; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YN/ZWP53"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A20C4CEF7;
	Tue, 17 Mar 2026 17:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773770050;
	bh=o9U4kP9BoiNmczBWmGX/rTwZTTh7SYM3gh/9l0lKK5A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YN/ZWP53WZKFsJBYj7miyTfZVQiB6a5duXQA2RfXaMvE9gM4IRaZ5HsVl6OjvoerZ
	 j8z2tgkrPsxwxEMECQQdReF1b2iw8I4MXKzNF19ccBz/sl6sOppVK0Yi/JRJGRAkEE
	 dhee2kUlcHo9wPfKlfUIEiec40IAeDHKYUG5DSTA0evvMFgE98j3kO0IZ5trHIWQBk
	 juxAL6+lB7L8pNG/+uD4V2Mie1pRTUbh2znkfMAql3LUqHM8aMyYDo070BEfctbPZU
	 9mAYYf8PtBSZzmyNxEgSHL/Gc3F39My8xxBfeaviAKcJoYo5rYsFNEx2+MWWQth0Ce
	 3mnOTnrLw21kg==
Date: Tue, 17 Mar 2026 07:54:09 -1000
Message-ID: <f397a5691ea770788818e17bc5fc8421@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: soolaugust@gmail.com
Cc: sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>,
 zhidao su <suzhidao@xiaomi.com>,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH] sched_ext: Fix typos in comments
In-Reply-To: <20260317075209.1197766-1-soolaugust@gmail.com>
References: <20260317075209.1197766-1-soolaugust@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.1.

Thanks.

--
tejun
