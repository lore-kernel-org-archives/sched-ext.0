Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6BF2066F7;
	Mon, 16 Mar 2026 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773653467; cv=none; b=NOYmMi4drEhSy3+W3vN3M/Y3F/W8IC6S7F7u9+1+GCpJSa+WdY5nN+tsN9FuCM8UvTL5l6AgLCLlESzRLsgTJlCKa+JmhaNnGKXucywdS/tn2rJOAxbqxiDKdikC0xOgnswOyXlLfeGdRQ1iL4vB+XwIFrZPbAU8HNH0uD7QSp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773653467; c=relaxed/simple;
	bh=J+I5wfTMMcbrocNgMBcPriOLF3E14DfuoYV4/m9qjqQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=h+tonctv73mYD1ADaP2vt6fIlF6lVZYo80n6O0ZnkBCjNl7jJHkSufoAqetl32KxRnE9tOUyJbWkRDxFYndohsPadzZ2fGNp8F0id3pr/r4NuWE5s7PS6CzQmJAyNWYB5Hle+QYrvGQ/7gg4NLDFo+5RRfgJ0Ig4QI0x6+sTRW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4l4evH3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4l4evH3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3D4C19421;
	Mon, 16 Mar 2026 09:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773653467;
	bh=J+I5wfTMMcbrocNgMBcPriOLF3E14DfuoYV4/m9qjqQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K4l4evH3Y8V8kSAE7H/1RBHPJwmbmz81pT0IF9FQhNHCq+U5/430HiSFsBnr/gBGB
	 cbmdcRnQK8XOQeZA304iWMjNSbtk+1lTpQdyWVKnDigH4+vl5SBjKZOU/9uAg4dM0N
	 SyQJ11YczPVYDUJXc7c0f1lubIPQfShZ+XSzGQbWuQN51nPxUHCbNZ99T2BKeqKRQ9
	 xbfyWT0pgv+VVJrRzT6FgTuTjeznIQ7cYRfL5xDPkCzI9Nt3lqcjqUq+4sb3rh25GV
	 +jQ1sICNmAQqhgaDGV2j73dCol5RbEAUA8FpkU6Ro9xqkFLtBiJhnaLqnkhij7k9rH
	 I0gQ5mlRyq3Og==
Date: Sun, 15 Mar 2026 23:31:06 -1000
Message-ID: <9ee1855588c8722b2b045df7da8408df@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>,
 David Carlier <devnexen@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix cgroup double-put on sub-sched
 abort path
In-Reply-To: <20260316054328.838304-2-tj@kernel.org>
References: <20260316054328.838304-1-tj@kernel.org>
 <20260316054328.838304-2-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

> Tejun Heo (2):
>   sched_ext: Fix cgroup double-put on sub-sched abort path
>   sched_ext: Use kobject_put() for kobject_init_and_add() failure in
>     scx_alloc_and_add_sched()

Applied 1-2 to sched_ext/for-7.1 w/ the Fixes tag updated per your
suggestion.

Thanks.

--
tejun
