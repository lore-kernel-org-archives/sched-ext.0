Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE393A9D90
	for <sched-ext@lists.linux.dev>; Mon, 20 Apr 2026 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776708124; cv=none; b=N9stRushqqeonpqAEsHI+Om4qKDugVAzhBNx6VIlIowCpaGdcW+6xdoyEYQpkEHx7OGlnbBdKbHv5yqnB8eVlxQwf7/mNyVCAsWka9ng5MYUX+Oh6YR8D+KT6XRXEZIwMuEjhXZjE7b5IbFt8nqUm7Wpxxeq/4kT5xJ9lAy4OOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776708124; c=relaxed/simple;
	bh=AL3RD12e+wd3hpXo+XZ4a0Ofa1msrCKNJWe1W8ilL1Y=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=ifHAcDxcxX7CJNaI3dmdsNoirhtYk3F2W7za051elrxsp0Lj5wqeFAJIJnM6WDWr1ZcXzZbShx2U3XHvUyi0Q1LEUb5cIacBiZHRSgij5kcJqt805+hOlb/tVqyYuvd7eRhlsJsc5xGOJPH14izwCopJVlJ+MrNpbahFIr57rWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4tlu2sr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4tlu2sr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E82C2BCB0;
	Mon, 20 Apr 2026 18:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776708124;
	bh=AL3RD12e+wd3hpXo+XZ4a0Ofa1msrCKNJWe1W8ilL1Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K4tlu2srp1jSww7TDHPSEQfjBSq5MfsgHa5VDBqcVovEHTs1st9oxdqIvWyvvpgzh
	 labM5cAacSB4rYZYE00ehz514NT9w/q6QGfiWElIkvTAdb28e3QWE/lAoVNup9S8te
	 kQ0859F8iLSgdHUfKQNrXU3E3pGkUr05mMezLnIlIJre3owaxQiVItnNS0DpRBCS45
	 owgT0fniRR+3QSOAQJmsnn4Qr+Cz+PYxwpybZn1TF/vQZ14mCAt8AELkmB3HHqG8L1
	 //5tguy/7uf4GNSmW+XfNWNpkSj7vUborBP8Gy8Reg2O9lAfBAOOCaZSndUvACRfgD
	 8XlZJ7dKMI3tQ==
Date: Mon, 20 Apr 2026 08:02:03 -1000
Message-ID: <fd9056e44169d272515dc5b94e334e7a@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v2 sched_ext/for-7.2] sched_ext: Documentation: clarify
 arena-backed doubly-linked lists in scx_qmap
In-Reply-To: <20260420065520.383127-1-yphbchou0911@gmail.com>
References: <20260420065520.383127-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.2.

Thanks.
--
tejun
