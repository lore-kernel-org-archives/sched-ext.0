Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6C438757C;
	Mon,  2 Mar 2026 17:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772472512; cv=none; b=cdDcUYuAd7W1FiQLOKq5xdbsxPnXYNhVz69g9l40NW49M+/lvBr8yp/RfYNEGpwkDTlZ/7k/hCvkjWRv35bP59cS7QilBKf2uspzbGD6eybPNG1yJe1e8JYRoNnscrsH9/kWQmn0sU7i5aOSWNdeA7ioiJwC5UNORUfKif4w0Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772472512; c=relaxed/simple;
	bh=NF7Sk8t4R9YUt0UjdHBkUG8WRMKSzXNJ7dVA4KUmKI8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=eTyZ+kT68ARwImJHweHslhOxvNLB7R16eMzhsKZL3CBqLmchEXyY08+Yir6syJSKMsrENo7/rb1lYb4fAelishzz3zWiaSdIySxgsrlKRQcnQJK/+Cr28krbr6wbTf+1RsV77e/tmRmEgLF0XGDOIGqsi+wu/t1fSRn/41+lr00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FehnnAKl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FehnnAKl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD768C19423;
	Mon,  2 Mar 2026 17:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772472511;
	bh=NF7Sk8t4R9YUt0UjdHBkUG8WRMKSzXNJ7dVA4KUmKI8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FehnnAKlBu6C5hXIxzjSvlqq8Nl3FUVFAMFS9cT9K9dONNtOn2EDOGFQz2IGqRbky
	 xGyOVYM+1OnsBsLk9oBtxx80wGNbxnrNbpGz7XSEzj6lK13V31SuHgQE0FztgPkMzY
	 uKUCiewiJRI28epxNQPAThwolgd/dLdMNGKDgCdQtxcUPVYdqOzMgxtHiCvZi/zueJ
	 VrqxvusPllVoMLEbTyhtVg82CCqZ6Q3WvGAlCsRk0lFBqUyRGrMrrenCMVp0IoTaEX
	 SS0xnLGvNAc/rud1J6Ki/IUO6i5ACTR+zYhj73IzLCoeR2dkZ4/y8kBBv+EhtbiN9A
	 A+s5kDeReydkw==
Date: Mon, 02 Mar 2026 07:28:30 -1000
Message-ID: <bbf62b9932405c61a1739f8a315bfcfa@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: zhidao su <soolaugust@gmail.com>
Cc: sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 peterz@infradead.org,
 mingo@redhat.com,
 zhidao su <suzhidao@xiaomi.com>
Subject: Re: [PATCH 1/2] sched_ext: Use READ_ONCE() for the read side of
 dsq->nr update
In-Reply-To: <20260302091440.3973220-1-soolaugust@gmail.com>
References: <20260302091440.3973220-1-soolaugust@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> zhidao su (2):
>   sched_ext: Use READ_ONCE() for the read side of dsq->nr update
>   sched_ext: Replace naked scx_root dereferences in kobject callbacks

Applied 1-2 to sched_ext/for-7.0-fixes.

Thanks.

-- 
tejun
