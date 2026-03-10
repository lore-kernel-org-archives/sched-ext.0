Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2633D16E9;
	Tue, 10 Mar 2026 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773162123; cv=none; b=HNOfkuJRn/qebo+S4nhvQlq9v/K10MUuu++oa0kZdgZw9erUGRsL0KXFJo53pBFuST4RZoqNfidHG87Szl5ihZWAbEmcosBbnwNrfVGbIH5gNlb7zXzB73yA2zScLwsSGAKBcVLkfiNuaUdOqPNzc3G859/XwPiLRtHCr2ej/Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773162123; c=relaxed/simple;
	bh=+0ix+E8GBUCgIN6jbrba74DKgOITHGZNkoqWjOpimuI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=uoOmBGTEB4YbolnQAwa7N1v0uyvFEwUCd0k+BzkLw273YwMwhwfCrLZsAlkLcgjrv3Aj/5eUvbpcEV1MYcXxgLuma6M6O5uNpKsNFVhgC/dGcLGAR5/n496YLH1yJDg7T9RUafy+BUHTqtTrkl0XWubUzyqEaNFIEDz77uOaK84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKT2D/Qf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKT2D/Qf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D94C19423;
	Tue, 10 Mar 2026 17:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773162123;
	bh=+0ix+E8GBUCgIN6jbrba74DKgOITHGZNkoqWjOpimuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CKT2D/QfDKqzZ8HFMRAqkM++G4/6BbdO5g4id2gW7koLSywOVdZthjH40qgrPLGWg
	 ymWMW7wXUoMYwEMMR7m6Ks6U8jW1JpYtKY85RmbV8l7yXHu6IMpEHlMVdZHNpvAoQD
	 +rp7ixyZa2WWZlZTrL41lmFQxVlU6el6AjUe5QEzHsn2myYy0HbIxJiDIm5s+PYWNF
	 v2SQzDeuOvrpEpxrOlXeSz8lzD7AKyDFVUvRf4xKQgyswcdfxAfM4BonZxkj1ryJnv
	 jz6zkklm8fn2g60G+mR70J6nDhp1AzoWJd6rCm14eZVomwk67SbKpyF124otFofPZ+
	 NgNUd0GU+mqHA==
Date: Tue, 10 Mar 2026 07:02:01 -1000
Message-ID: <1e76d679cac0be4c09d422d71743c9af@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH 16/61] sched: Prefer IS_ERR_OR_NULL over manual
 NULL check
In-Reply-To: <20260310-b4-is_err_or_null-v1-16-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-16-bd63b656022d@avm.de>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.1.

Thanks.

--
tejun
