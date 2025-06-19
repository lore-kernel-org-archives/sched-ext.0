Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064EE20CCE4
	for <sched-ext@lists.linux.dev>; Thu, 19 Jun 2025 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750325373; cv=none; b=awMGxuR0U/l5bgQc8PKXtqdkZcdu5dUSvffUb9ZoPfBCQ5yJ06vluJScVv/l6VDAkEOhk1iD3et8A/P0moo+HkWDaTb4DBd3dmttVmhr0EpY19K0Hb6cG9ZecoJunvQYMYWwj7i2WgTeENK+PaMLkufU6nO6q6y9IITDFromjaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750325373; c=relaxed/simple;
	bh=AWkR+LJcDtt2W1OWgddqDcSp8yBZvkZhByM94x2oZ4w=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=YuEvS2VFwZT+/S9WP5Q33Vsx1C0AkTKgClDuctKI1Xryij9pPjrlpNzm9DDIghWH6hFlWd8f0rVqQLlBztmmC9WYbZHb4/cqybo7FEzxOLqZ48nk1iTi5Ci5XY2AWLE9E5kgb0SPTEHsGgDgv0mawFesfNPAwlUeIM8K+1DgupI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=bC944fjd; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="bC944fjd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:To:From:Subject:
	Content-Type; bh=AWkR+LJcDtt2W1OWgddqDcSp8yBZvkZhByM94x2oZ4w=;
	b=bC944fjduisOK0jpn6Ug8uiIIujcXRKRyC1QAnYwuT8bwmxuvIOo4d9amLYI5k
	MNLdqOTHv+m16Gt13Ja8adwqlx81BlLfAF8ppZfcBzD1dc39wjWIMrG+Ns92+sXr
	7DfuiZz/s5V6ljJ2agJcWbn07+MiwN9vpog/z5BeFZhqQ=
Received: from [172.24.148.160] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3F+TTzVNoOL+dAA--.514S2;
	Thu, 19 Jun 2025 16:44:04 +0800 (CST)
Message-ID: <6730fe54-c9fe-4560-bac9-c152f14bff89@126.com>
Date: Thu, 19 Jun 2025 16:44:03 +0800
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: sched-ext@lists.linux.dev
From: Honglei Wang <jameshongleiwang@126.com>
Subject: subscribe sched-ext
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3F+TTzVNoOL+dAA--.514S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUnBTYUUUUU
X-CM-SenderInfo: 5mdpv2pkrqwzphlzt0bj6rjloofrz/1tbiYBRxrWhTxRzHRQAAsI

subscribe sched-ext

