Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FB34E0B9F;
	Thu, 17 Sep 2026 16:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663892; cv=none; b=N+Ut2d3wG8Ukv7zLa0e4hAOADNLsyiqGS1LzxSS56JIN7aPicqvn7KCpoQzgD0CZVpACIynCzVbF3mIqGTzMEqoHgliOTN1ZSl5WZPPMujlly2TkDM9cc5xTrLoIFLJluAtjlHXtQESkkEd7lBWSwkoGANm/LFJ+P1hNaURqt7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663892; c=relaxed/simple;
	bh=6Y7vYf/xc/TsRZfeinhAcNhu9VUF65Y4YoGWlsYueBI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=O8TrIUh65rzZdySBd8HKdeJbW1xzNJlkYXkkwuxVvitlzPq+8GptJ+ELhRH9e3AZgsR9kqlHOYT8E/jp2M7uqbpbg8FVkUc5L7JnQm2GAlyCysJghAVQiLfwYRJVYoa/SrNtSr9QT7faBqKmu4ttdLjmI84Z8lOXQlQ40yEfE+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxbZhCok; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxbZhCok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAB91F000FF;
	Thu, 17 Sep 2026 16:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789663891;
	bh=6Y7vYf/xc/TsRZfeinhAcNhu9VUF65Y4YoGWlsYueBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BxbZhCokIJvEptEerSReRE182Pwyh87AVKxNe/KPTi793uljEy0jX0mmjLsvxMvv8
	 h6H8/ObWUnCkxHvXqHJU/omftk+0oKf14aNsSNQoNsXSSLm4iEY4RgN7Mc9+l54udj
	 HqrydwPpdlC9lMTWI7a8WcKhuWoKCQOdobbG1uWtkl9Fth8x0iEZbHo7Cph3n+vlfN
	 DFvF1xLU2Y10fOUErgCOHXzGtSKf7sYl5F4HEmGdEmkbQONkSkNbyoI1oAbw/zDbW6
	 T+KZWmN0kDMKz5bh0Jr0BD6cczIwMKN3F+xaqhv7gnlxyzpOQr+oS8YVoycokp7GBA
	 ErU8Nc7DgnqLw==
Date: Thu, 17 Sep 2026 06:51:30 -1000
Message-ID: <613ba34982346602155a2f1ff5b6582a@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Tejun Heo <tj@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 Cheng-Yang Chou <yphbchou0911@gmail.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.3-fixes] sched_ext: Derive
 SCX_RQ_IN_WAKEUP from the core enqueue flags
In-Reply-To: <20260916215713.2701551-1-tj@kernel.org>
References: <20260916215713.2701551-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.3-fixes.

Thanks.

--
tejun
