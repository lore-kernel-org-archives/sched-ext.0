Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57B026F29B
	for <sched-ext@lists.linux.dev>; Tue,  7 Apr 2026 18:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775586644; cv=none; b=eQP+iSvaQLHQgbPCTYWKzxWUY8XwF4MY3leGT0GdBYKgMDh7dVHFeCFSlHo1GKNj9Lr/7++IqfYoM2y7RU5gwS0qQlfZuik4e66haWqk6I3+U9UqDO6crlfWOPPLTJUsMxAy7gfRDJx9yitf3iRQpj6No9UZj/yaQhnhiUJj3r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775586644; c=relaxed/simple;
	bh=CfaEYSxJ7VvkwZoO0twsjVu5Y0t1QYa9x7rxj/1BqBk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=t7Jn0ULFS5pvP8Z5KrvfXrmGhYRYwpHZQ+MGvBqAIcCdCy5Kmn9eEVBoCO/AwRJdfwD34IVMrqkSIgGn7/Ti1DIefWFmeYcPpMPU+5IhBfMakbFD7RkXG/lx0Z+rYTZAIPWbQqqNGzSMBlEz2bHYGdCbD4qPgQ1Y1JtKu1M6JjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+0bnhSF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+0bnhSF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFD5C116C6;
	Tue,  7 Apr 2026 18:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775586644;
	bh=CfaEYSxJ7VvkwZoO0twsjVu5Y0t1QYa9x7rxj/1BqBk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K+0bnhSF/cTJNnnMwG4N0HbGzO02ld1Iqc4hj5p1P76z5mlbk0VcjG+7k2PiST8l+
	 ouGg8P+z1yCa9Q7f6gCHKiDYP8HwE956wRlcLPM8YE16hk62oU/56PrZbRcDrXfK1F
	 KyG95SlFogntnT3/W8duxuFmqlQXr9yuSwjUd8EekYYkqGrNwh6PJpOrhg2FHxZZXD
	 fgkBzz51QTtjgfVR4Vm71zmQpYKiMh16wrN2WHk4Q3np5oOTLCj4gXfzKoRb9efJzX
	 xCQd9v3QZ3RzVa1E1GEFGPxsomP71pDyztLQs9N0SWN4naGb29xjyab9r0sxUR3pMG
	 Hb3wQAn+pQZIw==
Date: Tue, 07 Apr 2026 08:30:43 -1000
Message-ID: <f5f5e8a710d00c4ea4af4840fd32aad3@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH sched_ext/for-7.1] selftests/sched_ext: Improve runner error reporting for invalid arguments
In-Reply-To: <20260407174912.3156824-1-yphbchou0911@gmail.com>
References: <20260407174912.3156824-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Wed, Apr  8, 2026 at 01:49:02AM +0800, Cheng-Yang Chou wrote:
> +	if (filter && testnum == 0 && !exit_req) {

testnum is also bumped by the print_skipped path, so with
`-s -t nomatch` this check never fires.

Thanks.

--
tejun
