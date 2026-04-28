Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A0A280037;
	Tue, 28 Apr 2026 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393906; cv=none; b=Yfuw9BMORRun06uPYIY7FM7bqy7MhQ9kkym3bIm4KCpsPqLMKSEVw+7RS36+XjXewnCSCU20y+KbBCWAXQ62PfXyUCcZeVE9h66wkXuunJlbtuo/DT5ADoL5Ir0dsAgHu0VV97AhsOYUDFWJGwhWXb7EOQbykk+hthIFLplmZno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393906; c=relaxed/simple;
	bh=xkv4rowQSbrlz+DtnyHzM6Q4ND/p6P6zl8wnb2i6vJM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=KqRczzoMNgIQXgJ6FWggnBiIwGy4FcsmsNviUTAwAP+++vpc90PZzPzLLebEwRT+czNxwt6340JJ7LfmCvh01DU+s9BSw3yOo8DzqFUc1dgtcdrc65RGtRf8kDWT0ej/PY/TeX1bzPaflcG19qbDun/wRYZASVs8RmW76Oop+dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKh8fdpz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKh8fdpz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4252C2BCB5;
	Tue, 28 Apr 2026 16:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777393906;
	bh=xkv4rowQSbrlz+DtnyHzM6Q4ND/p6P6zl8wnb2i6vJM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pKh8fdpzu+MYE3fOEU1FJmTg53M1FmWiZsczLxWiWYyvfkbLXCZA86prizNH4nzBR
	 qWIUJa3M0YvA+hZjrp47tDa6fQ7apQTAJr0iaFkg0OIagI7DmBXWhTxZzqsWC7iyzL
	 3ZnRilLhIDjdtoqJ8wuVYRIoChZyddH1TVlF1mvoYCUZaRjZb7LZtMV/eAh26wNF58
	 sYVDnOmlX5WewJLndr72m+b6zR2rwBzftztmSri2iYSUHXPlnp7PhlWV/qw/YlgyG7
	 N5nbItn4dG2Klo+CEs/GOnGV27pp/KQvuLjGdMtkGEhhOfwN10PuI78zb4n3DgCnjm
	 YLLxRJJBOgO8g==
Date: Tue, 28 Apr 2026 06:31:45 -1000
Message-ID: <8cc47642ad80df8e067516e8de56ea88@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 David Vernet <void@manifault.com>,
 linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev,
 Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 sched_ext/for-7.1-fixes] sched_ext: Call
 wakeup_preempt() in local_dsq_post_enq()
In-Reply-To: <20260428124601.3017925-1-jpiecuch@google.com>
References: <20260428124601.3017925-1-jpiecuch@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.1-fixes.

Thanks.

--
tejun
