Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99A823392B
	for <sched-ext@lists.linux.dev>; Tue, 30 Jun 2026 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829481; cv=none; b=nMuUsUQqXP0fbc34kH24V79DhwOFxI2RexpYZtjgSYqRj1vzSCiqC58VN91EkBK+DPFn9qWnhKA2E75X0OiSDcJjUSHJLtx6hNKDWrYqD0gIbZSyXIlehyCY9YnIw5s0pJIt9S0je4qOL7c0TB1vN6iTmm+cOUjbS1Wv/78TxxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829481; c=relaxed/simple;
	bh=QZy+W4+BNWiqF7AxQn8o27OELqmWr3Sc1evQOKfzb4s=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=DWGX7a1Bwh4CrunIhr4ibxZPn2NQY8zjoT7C9u+1RKD4tk97wNrwOh3LHlKNaLor8lX513BAvIdWugH/d5A11SMjbPomvkS2yemqCNtXKHBseJc8upg/ymnEMKiRBEqsQ4pu4x600L1biC30g1FjuqvYQSOD86Pa0HOIbwS9clk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4rkKv+4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4rkKv+4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B811F000E9;
	Tue, 30 Jun 2026 14:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782829480;
	bh=QZy+W4+BNWiqF7AxQn8o27OELqmWr3Sc1evQOKfzb4s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=J4rkKv+4kthIsFmluyfSzhHiIezvcvEa2Hvv5jSwBZNoioh8k8jyjjorv86mwGz2q
	 ERP1icbMUY59drFI/ZSVv7mXzbzzxBflpr+JbMWzctJF4YGQ81wdaOYPlz7vrbg7LN
	 mtU3aC2cTUaYabF0U+h6/Zwi0Ilkjvw5w0HdVBcz9In0WLKZBWsMgH/twXl2Dqhy+6
	 Z9T1dU8oWV1lM1iaq92wwW9FqW/D95kutH8J3VpsPMsetvZ27K9lDsjDNNU0NrgSRT
	 x2yZ/t4cGTN+62v0XhzS2mbHVOvxut6iWCk4GIl3scInEPqsX5xW4HdfZN294umbU+
	 c9sR0lCGRl6aw==
Date: Tue, 30 Jun 2026 04:24:39 -1000
Message-ID: <f418c9d531db82c254f62fb85b10bf7a@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	chengyang.chou@mediatek.com
Subject: Re: [PATCH v2 sched_ext/for-7.3] sched_ext: Replace open-coded event lists with SCX_EVENTS_LIST
In-Reply-To: <20260630140645.8855-1-yphbchou0911@gmail.com>
References: <20260630140645.8855-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.3.

Thanks.
--
tejun
