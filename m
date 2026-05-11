Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C7E2D9ECA;
	Mon, 11 May 2026 08:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489568; cv=none; b=VFQpPqFu9e82B86passzO8KCHj442EacOPp4YP0AKg3xWWsc8byTZJOT0nre1jMW5wNoRmQfVCgqJ4Y6Nc7A7Cgz15snVSPvDuYEWhdPTt6zKgvmRhsY2GitdRDL86QOOpZzwvEca4eLsrJmoeUnD/g5kITPrLIu7iCdPAg27TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489568; c=relaxed/simple;
	bh=//YlwQ31X8i4Pw3PlbMrvvV8D9TAUc8vBVVi1yslbAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YjqXXDlzwmaGhNyc/gi1LFUQTDZ+0t4J/M//WVZuDmHIBLE8R2CbQpYjiD9NfAPRJwZPLXHdnXK8VsgIg0rqVMgr1raDT9Rd5QUbyxmpzB7mF5Jet6GMBGBOW8lfiNjt22gB4TnBrfrmtBnK0Fb3xwPXQ//m5zTnS+pRASG++g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQadlPEs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQadlPEs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF24CC2BCB0;
	Mon, 11 May 2026 08:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778489568;
	bh=//YlwQ31X8i4Pw3PlbMrvvV8D9TAUc8vBVVi1yslbAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mQadlPEsZTIr3czG2tcgbiZ1tiZCq/CU7ZTwi9txlUhRTqiqSIZ+W91cLygudyCje
	 OJSe/sEqqquRx/rrg8GDPwoQwL6BI+tlsOGJi5MVGBGhgyynA+uZ9Bbe3XC8V6MKZx
	 bYXGPMH9VJJ+69T5MqcmcW+10F7cb9rXuNi8ATq4Bwvj56rA42Eu4AerAKevxFYAWe
	 OoNYNIKJ7wjvWmtPjJqLrDphw4cU+GBFWGvsQ8EBnqxbwCppfl60VdElE4aF9ThYF/
	 GS2AUmvTHqTmCQ8WrfmvRO1tRgJb+UwfgJ8Agcp7ZGKJcIdbvzt9XQJdVzKEO7bCQ/
	 YW4F3afAdFwHQ==
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1-fixes] sched_ext: Clear ops->priv on scx_alloc_and_add_sched() error paths
Date: Sun, 10 May 2026 22:52:46 -1000
Message-ID: <20260511085246.3277679-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511083130.3174880-1-arighi@nvidia.com>
References: <20260511083130.3174880-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Mon, May 11, 2026 at 10:31:30AM +0200, Andrea Righi wrote:
> sched_ext: Clear ops->priv on scx_alloc_and_add_sched() error paths

Applied to sched_ext/for-7.1-fixes.

Thanks.

--
tejun
